import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../models/enums.dart';
import '../../models/rental_contract.dart';
import '../contract_repository.dart';
import '../repository_exception.dart';

class DriftContractRepository implements ContractRepository {
  DriftContractRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<RentalContract>> watchAll({
    ContractQuery query = const ContractQuery(),
  }) {
    final SimpleSelectStatement<$RentalContractsTable, RentalContractRow>
        select = _db.select(_db.rentalContracts)
          ..orderBy(<OrderClauseGenerator<$RentalContractsTable>>[
            ($RentalContractsTable t) => OrderingTerm.desc(t.startAt),
            ($RentalContractsTable t) => OrderingTerm.desc(t.id),
          ]);
    final ContractStatus? status = query.status;
    if (status != null) {
      select.where(
        ($RentalContractsTable t) => t.status.equalsValue(status),
      );
    }
    final int? customerId = query.customerId;
    if (customerId != null) {
      select.where(
        ($RentalContractsTable t) => t.customerId.equals(customerId),
      );
    }
    final int? trailerId = query.trailerId;
    if (trailerId != null) {
      select.where(
        ($RentalContractsTable t) => t.trailerId.equals(trailerId),
      );
    }
    return select.watch().map(
          (List<RentalContractRow> rows) => rows.map(_map).toList(),
        );
  }

  @override
  Stream<RentalContract?> watchById(int id) {
    return (_db.select(_db.rentalContracts)
          ..where(($RentalContractsTable t) => t.id.equals(id)))
        .watchSingleOrNull()
        .map((RentalContractRow? row) => row == null ? null : _map(row));
  }

  @override
  Future<RentalContract> create(
    RentalContractDraft draft, {
    required int userId,
  }) {
    return _db.transaction(() async {
      await _validate(draft);
      final int id = await _db.into(_db.rentalContracts).insert(
            RentalContractsCompanion.insert(
              customerId: draft.customerId,
              trailerId: draft.trailerId,
              startAt: draft.startAt,
              endAt: draft.endAt,
              pickupLocation: draft.pickupLocation.trim(),
              returnLocation: draft.returnLocation.trim(),
              priceCents: draft.priceCents,
              status: ContractStatus.planned,
              createdByUserId: userId,
            ),
          );
      return _map(await _requireRow(id));
    });
  }

  @override
  Future<void> update(int id, RentalContractDraft draft) {
    return _db.transaction(() async {
      final RentalContractRow row = await _requireRow(id);
      if (row.status != ContractStatus.planned) {
        throw const RepositoryException(RepositoryError.contractNotEditable);
      }
      await _validate(draft, excludeId: id);
      await _write(
        id,
        RentalContractsCompanion(
          customerId: Value<int>(draft.customerId),
          trailerId: Value<int>(draft.trailerId),
          startAt: Value<DateTime>(draft.startAt),
          endAt: Value<DateTime>(draft.endAt),
          pickupLocation: Value<String>(draft.pickupLocation.trim()),
          returnLocation: Value<String>(draft.returnLocation.trim()),
          priceCents: Value<int>(draft.priceCents),
          updatedAt: Value<DateTime>(DateTime.now()),
        ),
      );
    });
  }

  @override
  Future<void> handOver(int id, {required int userId}) {
    return _db.transaction(() async {
      final RentalContractRow contract = await _requireRow(id);
      if (contract.status != ContractStatus.planned) {
        throw const RepositoryException(
          RepositoryError.invalidContractTransition,
        );
      }
      final TrailerRow trailer = await _requireTrailer(contract.trailerId);
      if (trailer.archivedAt != null) {
        throw const RepositoryException(RepositoryError.trailerArchived);
      }
      if (trailer.status != TrailerStatus.available) {
        throw const RepositoryException(RepositoryError.trailerNotAvailable);
      }
      final DateTime now = DateTime.now();
      await _write(
        id,
        RentalContractsCompanion(
          status: const Value<ContractStatus>(ContractStatus.active),
          handedOverAt: Value<DateTime?>(now),
          updatedAt: Value<DateTime>(now),
        ),
      );
      await _setTrailerStatus(
        trailer: trailer,
        status: TrailerStatus.rented,
        contractId: id,
        userId: userId,
        now: now,
      );
    });
  }

  @override
  Future<void> completeReturn(int id, {required int userId}) {
    return _db.transaction(() async {
      final RentalContractRow contract = await _requireRow(id);
      if (contract.status != ContractStatus.active) {
        throw const RepositoryException(
          RepositoryError.invalidContractTransition,
        );
      }
      final TrailerRow trailer = await _requireTrailer(contract.trailerId);
      final DateTime now = DateTime.now();
      await _write(
        id,
        RentalContractsCompanion(
          status: const Value<ContractStatus>(ContractStatus.completed),
          returnedAt: Value<DateTime?>(now),
          updatedAt: Value<DateTime>(now),
        ),
      );
      await _setTrailerStatus(
        trailer: trailer,
        status: TrailerStatus.available,
        contractId: id,
        userId: userId,
        now: now,
      );
    });
  }

  @override
  Future<void> cancel(int id) {
    return _db.transaction(() async {
      final RentalContractRow contract = await _requireRow(id);
      if (contract.status != ContractStatus.planned) {
        throw const RepositoryException(
          RepositoryError.invalidContractTransition,
        );
      }
      await _write(
        id,
        RentalContractsCompanion(
          status: const Value<ContractStatus>(ContractStatus.cancelled),
          updatedAt: Value<DateTime>(DateTime.now()),
        ),
      );
    });
  }

  Future<void> _validate(RentalContractDraft draft, {int? excludeId}) async {
    if (!draft.endAt.isAfter(draft.startAt)) {
      throw const RepositoryException(RepositoryError.invalidDateRange);
    }
    if (draft.priceCents < 0) {
      throw const RepositoryException(RepositoryError.invalidAmount);
    }
    final TrailerRow trailer = await _requireTrailer(draft.trailerId);
    if (trailer.archivedAt != null) {
      throw const RepositoryException(RepositoryError.trailerArchived);
    }
    final CustomerRow? customer = await (_db.select(_db.customers)
          ..where(($CustomersTable t) => t.id.equals(draft.customerId)))
        .getSingleOrNull();
    if (customer == null) {
      throw const RepositoryException(RepositoryError.notFound);
    }
    if (customer.archivedAt != null) {
      throw const RepositoryException(RepositoryError.customerArchived);
    }
    final List<RentalContractRow> others =
        await (_db.select(_db.rentalContracts)
              ..where(
                ($RentalContractsTable t) => t.trailerId.equals(draft.trailerId),
              ))
            .get();
    final bool overlaps = others.any(
      (RentalContractRow other) =>
          other.id != excludeId &&
          other.status.blocksTrailer &&
          other.startAt.isBefore(draft.endAt) &&
          other.endAt.isAfter(draft.startAt),
    );
    if (overlaps) {
      throw const RepositoryException(RepositoryError.contractOverlap);
    }
  }

  Future<void> _setTrailerStatus({
    required TrailerRow trailer,
    required TrailerStatus status,
    required int contractId,
    required int userId,
    required DateTime now,
  }) async {
    if (trailer.status == status) {
      return;
    }
    await (_db.update(_db.trailers)
          ..where(($TrailersTable t) => t.id.equals(trailer.id)))
        .write(
      TrailersCompanion(
        status: Value<TrailerStatus>(status),
        updatedAt: Value<DateTime>(now),
      ),
    );
    await _db.into(_db.trailerStatusChanges).insert(
          TrailerStatusChangesCompanion.insert(
            trailerId: trailer.id,
            oldStatus: Value<TrailerStatus?>(trailer.status),
            newStatus: status,
            changedAt: Value<DateTime>(now),
            changedByUserId: userId,
            rentalContractId: Value<int?>(contractId),
          ),
        );
  }

  Future<RentalContractRow> _requireRow(int id) async {
    final RentalContractRow? row = await (_db.select(_db.rentalContracts)
          ..where(($RentalContractsTable t) => t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) {
      throw const RepositoryException(RepositoryError.notFound);
    }
    return row;
  }

  Future<TrailerRow> _requireTrailer(int id) async {
    final TrailerRow? row = await (_db.select(_db.trailers)
          ..where(($TrailersTable t) => t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) {
      throw const RepositoryException(RepositoryError.notFound);
    }
    return row;
  }

  Future<void> _write(int id, RentalContractsCompanion companion) {
    return (_db.update(_db.rentalContracts)
          ..where(($RentalContractsTable t) => t.id.equals(id)))
        .write(companion);
  }

  RentalContract _map(RentalContractRow row) {
    return RentalContract(
      id: row.id,
      customerId: row.customerId,
      trailerId: row.trailerId,
      startAt: row.startAt,
      endAt: row.endAt,
      pickupLocation: row.pickupLocation,
      returnLocation: row.returnLocation,
      priceCents: row.priceCents,
      status: row.status,
      handedOverAt: row.handedOverAt,
      returnedAt: row.returnedAt,
      createdByUserId: row.createdByUserId,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }
}
