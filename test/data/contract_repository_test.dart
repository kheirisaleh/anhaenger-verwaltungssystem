import 'package:anhaenger_verwaltungssystem/core/database/app_database.dart';
import 'package:anhaenger_verwaltungssystem/data/models/enums.dart';
import 'package:anhaenger_verwaltungssystem/data/models/rental_contract.dart';
import 'package:anhaenger_verwaltungssystem/data/models/trailer.dart';
import 'package:anhaenger_verwaltungssystem/data/repositories/drift/drift_contract_repository.dart';
import 'package:anhaenger_verwaltungssystem/data/repositories/drift/drift_customer_repository.dart';
import 'package:anhaenger_verwaltungssystem/data/repositories/drift/drift_trailer_repository.dart';
import 'package:anhaenger_verwaltungssystem/data/repositories/repository_exception.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_database.dart';

void main() {
  late AppDatabase db;
  late DriftContractRepository contracts;
  late DriftTrailerRepository trailers;
  late int userId;
  late int trailerId;
  late int customerId;

  final DateTime start = DateTime(2026, 11, 2, 9);
  final DateTime end = DateTime(2026, 11, 4, 18);

  RentalContractDraft draft({DateTime? from, DateTime? until, int price = 4990}) {
    return RentalContractDraft(
      customerId: customerId,
      trailerId: trailerId,
      startAt: from ?? start,
      endAt: until ?? end,
      pickupLocation: 'Filiale Nord',
      returnLocation: 'Filiale Nord',
      priceCents: price,
    );
  }

  setUp(() async {
    db = createTestDatabase();
    contracts = DriftContractRepository(db);
    trailers = DriftTrailerRepository(db);
    userId = await defaultUserId(db);
    trailerId = (await createTestTrailer(db)).id;
    customerId = (await createTestCustomer(db)).id;
  });

  tearDown(() => db.close());

  test('neuer Vertrag ist geplant und aendert den Anhaenger nicht', () async {
    final RentalContract contract =
        await contracts.create(draft(), userId: userId);

    expect(contract.status, ContractStatus.planned);
    expect(contract.isEditable, isTrue);
    final Trailer? trailer = await trailers.watchById(trailerId).first;
    expect(trailer?.status, TrailerStatus.available);
  });

  test('ungueltiger Zeitraum und negativer Preis werden abgelehnt', () async {
    await expectLater(
      contracts.create(draft(from: end, until: start), userId: userId),
      throwsRepositoryError(RepositoryError.invalidDateRange),
    );
    await expectLater(
      contracts.create(draft(price: -1), userId: userId),
      throwsRepositoryError(RepositoryError.invalidAmount),
    );
  });

  test('ueberlappende Vertraege werden abgelehnt', () async {
    await contracts.create(draft(), userId: userId);

    await expectLater(
      contracts.create(
        draft(
          from: DateTime(2026, 11, 4, 12),
          until: DateTime(2026, 11, 6, 12),
        ),
        userId: userId,
      ),
      throwsRepositoryError(RepositoryError.contractOverlap),
    );
  });

  test('angrenzende und stornierte Vertraege blockieren nicht', () async {
    final RentalContract first = await contracts.create(draft(), userId: userId);
    await contracts.create(
      draft(from: end, until: DateTime(2026, 11, 6, 18)),
      userId: userId,
    );
    await contracts.cancel(first.id);

    final RentalContract replacement = await contracts.create(
      draft(),
      userId: userId,
    );
    expect(replacement.status, ContractStatus.planned);
  });

  test('Uebergabe und Rueckgabe steuern den Anhaengerstatus', () async {
    final RentalContract contract =
        await contracts.create(draft(), userId: userId);

    await contracts.handOver(contract.id, userId: userId);
    expect(
      (await trailers.watchById(trailerId).first)?.status,
      TrailerStatus.rented,
    );
    expect(
      (await contracts.watchById(contract.id).first)?.status,
      ContractStatus.active,
    );
    await expectLater(
      trailers.changeStatus(
        trailerId,
        TrailerStatus.maintenance,
        userId: userId,
      ),
      throwsRepositoryError(RepositoryError.statusChangeNotAllowed),
    );

    await contracts.completeReturn(contract.id, userId: userId);
    final RentalContract? returned =
        await contracts.watchById(contract.id).first;
    expect(returned?.status, ContractStatus.completed);
    expect(returned?.returnedAt, isNotNull);
    expect(
      (await trailers.watchById(trailerId).first)?.status,
      TrailerStatus.available,
    );

    final List<TrailerStatusChange> history =
        await trailers.watchStatusHistory(trailerId).first;
    expect(
      history.where((TrailerStatusChange c) => c.rentalContractId == contract.id),
      hasLength(2),
    );
  });

  test('Uebergabe nur bei verfuegbarem Anhaenger', () async {
    final RentalContract contract =
        await contracts.create(draft(), userId: userId);
    await trailers.changeStatus(
      trailerId,
      TrailerStatus.maintenance,
      userId: userId,
    );

    await expectLater(
      contracts.handOver(contract.id, userId: userId),
      throwsRepositoryError(RepositoryError.trailerNotAvailable),
    );
  });

  test('nur geplante Vertraege sind bearbeitbar und stornierbar', () async {
    final RentalContract contract =
        await contracts.create(draft(), userId: userId);
    await contracts.update(contract.id, draft(price: 5990));
    expect(
      (await contracts.watchById(contract.id).first)?.priceCents,
      5990,
    );

    await contracts.handOver(contract.id, userId: userId);

    await expectLater(
      contracts.update(contract.id, draft()),
      throwsRepositoryError(RepositoryError.contractNotEditable),
    );
    await expectLater(
      contracts.cancel(contract.id),
      throwsRepositoryError(RepositoryError.invalidContractTransition),
    );
  });

  test('Anhaenger und Kunden mit offenen Vertraegen sind nicht archivierbar',
      () async {
    await contracts.create(draft(), userId: userId);

    await expectLater(
      trailers.archive(trailerId),
      throwsRepositoryError(RepositoryError.trailerHasOpenContracts),
    );
    await expectLater(
      DriftCustomerRepository(db).archive(customerId),
      throwsRepositoryError(RepositoryError.customerHasOpenContracts),
    );
  });
}
