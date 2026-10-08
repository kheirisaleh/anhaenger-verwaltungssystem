import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../models/customer.dart';
import '../customer_repository.dart';
import '../repository_exception.dart';

class DriftCustomerRepository implements CustomerRepository {
  DriftCustomerRepository(this._db);

  final AppDatabase _db;

  @override
  Stream<List<Customer>> watchAll({
    String? search,
    bool includeArchived = false,
  }) {
    final SimpleSelectStatement<$CustomersTable, CustomerRow> query =
        _db.select(_db.customers)
          ..orderBy(<OrderClauseGenerator<$CustomersTable>>[
            ($CustomersTable t) => OrderingTerm.asc(t.lastName),
            ($CustomersTable t) => OrderingTerm.asc(t.firstName),
          ]);
    if (!includeArchived) {
      query.where(($CustomersTable t) => t.archivedAt.isNull());
    }
    final String term = search?.trim() ?? '';
    if (term.isNotEmpty) {
      final String pattern = '%$term%';
      query.where(
        ($CustomersTable t) =>
            t.firstName.like(pattern) |
            t.lastName.like(pattern) |
            t.email.like(pattern) |
            t.phone.like(pattern) |
            t.city.like(pattern),
      );
    }
    return query.watch().map(
      (List<CustomerRow> rows) => rows.map(_map).toList(),
    );
  }

  @override
  Stream<Customer?> watchById(int id) {
    return (_db.select(_db.customers)
          ..where(($CustomersTable t) => t.id.equals(id)))
        .watchSingleOrNull()
        .map((CustomerRow? row) => row == null ? null : _map(row));
  }

  @override
  Future<Customer> create(CustomerDraft draft) {
    return _db.transaction(() async {
      final int id = await _db
          .into(_db.customers)
          .insert(
            CustomersCompanion.insert(
              firstName: draft.firstName.trim(),
              lastName: draft.lastName.trim(),
              email: draft.email.trim(),
              phone: draft.phone.trim(),
              street: draft.street.trim(),
              postalCode: draft.postalCode.trim(),
              city: draft.city.trim(),
              licenseNumber: Value<String?>(_optional(draft.licenseNumber)),
            ),
          );
      return _map(await _requireRow(id));
    });
  }

  @override
  Future<void> update(int id, CustomerDraft draft) {
    return _db.transaction(() async {
      await _requireRow(id);
      await (_db.update(
        _db.customers,
      )..where(($CustomersTable t) => t.id.equals(id))).write(
        CustomersCompanion(
          firstName: Value<String>(draft.firstName.trim()),
          lastName: Value<String>(draft.lastName.trim()),
          email: Value<String>(draft.email.trim()),
          phone: Value<String>(draft.phone.trim()),
          street: Value<String>(draft.street.trim()),
          postalCode: Value<String>(draft.postalCode.trim()),
          city: Value<String>(draft.city.trim()),
          licenseNumber: Value<String?>(_optional(draft.licenseNumber)),
          updatedAt: Value<DateTime>(DateTime.now()),
        ),
      );
    });
  }

  @override
  Future<void> archive(int id) {
    return _db.transaction(() async {
      final CustomerRow row = await _requireRow(id);
      if (row.archivedAt != null) {
        return;
      }
      final List<RentalContractRow> contracts = await (_db.select(
        _db.rentalContracts,
      )..where(($RentalContractsTable t) => t.customerId.equals(id))).get();
      if (contracts.any((RentalContractRow c) => c.status.blocksTrailer)) {
        throw const RepositoryException(
          RepositoryError.customerHasOpenContracts,
        );
      }
      final DateTime now = DateTime.now();
      await (_db.update(
        _db.customers,
      )..where(($CustomersTable t) => t.id.equals(id))).write(
        CustomersCompanion(
          archivedAt: Value<DateTime?>(now),
          updatedAt: Value<DateTime>(now),
        ),
      );
    });
  }

  @override
  Future<void> restore(int id) {
    return _db.transaction(() async {
      await _requireRow(id);
      await (_db.update(
        _db.customers,
      )..where(($CustomersTable t) => t.id.equals(id))).write(
        CustomersCompanion(
          archivedAt: const Value<DateTime?>(null),
          updatedAt: Value<DateTime>(DateTime.now()),
        ),
      );
    });
  }

  Future<CustomerRow> _requireRow(int id) async {
    final CustomerRow? row = await (_db.select(
      _db.customers,
    )..where(($CustomersTable t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) {
      throw const RepositoryException(RepositoryError.notFound);
    }
    return row;
  }

  String? _optional(String? value) {
    final String trimmed = value?.trim() ?? '';
    return trimmed.isEmpty ? null : trimmed;
  }

  Customer _map(CustomerRow row) {
    return Customer(
      id: row.id,
      firstName: row.firstName,
      lastName: row.lastName,
      email: row.email,
      phone: row.phone,
      street: row.street,
      postalCode: row.postalCode,
      city: row.city,
      licenseNumber: row.licenseNumber,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      archivedAt: row.archivedAt,
    );
  }
}
