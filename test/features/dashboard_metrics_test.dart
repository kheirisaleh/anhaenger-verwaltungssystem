import 'package:anhaenger_verwaltungssystem/data/models/enums.dart';
import 'package:anhaenger_verwaltungssystem/data/models/rental_contract.dart';
import 'package:anhaenger_verwaltungssystem/data/models/trailer.dart';
import 'package:anhaenger_verwaltungssystem/features/dashboard/application/dashboard_metrics.dart';
import 'package:flutter_test/flutter_test.dart';

Trailer trailer(int id, TrailerStatus status, {String type = 'Tieflader'}) {
  final DateTime created = DateTime(2025);
  return Trailer(
    id: id,
    internalCode: 'T-$id',
    licensePlate: 'DD-T $id',
    type: TrailerType(id: type.length, name: type),
    status: status,
    location: const TrailerLocation(),
    createdAt: created,
    updatedAt: created,
  );
}

RentalContract contract(
  int id,
  int trailerId,
  DateTime start,
  Duration length,
  ContractStatus status,
  int price,
) {
  return RentalContract(
    id: id,
    customerId: 1,
    trailerId: trailerId,
    startAt: start,
    endAt: start.add(length),
    pickupLocation: 'A',
    returnLocation: 'B',
    priceCents: price,
    status: status,
    createdByUserId: 1,
    createdAt: start,
    updatedAt: start,
  );
}

void main() {
  final DateTime now = DateTime(2026, 10, 15, 12);
  final List<Trailer> trailers = <Trailer>[
    trailer(1, TrailerStatus.rented),
    trailer(2, TrailerStatus.available, type: 'Pkw-Anhänger'),
  ];
  final List<RentalContract> contracts = <RentalContract>[
    contract(1, 1, DateTime(2026, 10, 1), const Duration(days: 2), ContractStatus.completed, 10000),
    contract(2, 1, DateTime(2026, 10, 14), const Duration(days: 4), ContractStatus.active, 5000),
    contract(3, 2, DateTime(2026, 10, 20), const Duration(days: 1), ContractStatus.planned, 3000),
    contract(4, 2, DateTime(2026, 10, 22), const Duration(days: 1), ContractStatus.cancelled, 9999),
    contract(5, 2, DateTime(2025, 3, 1), const Duration(days: 1), ContractStatus.completed, 7000),
    contract(6, 1, DateTime(2026, 2, 1), const Duration(days: 4), ContractStatus.completed, 2000),
  ];

  final DashboardMetrics metrics = DashboardMetrics.compute(
    trailers: trailers,
    contracts: contracts,
    now: now,
  );

  test('Fuhrpark nach Status', () {
    expect(metrics.statusCounts[TrailerStatus.rented], 1);
    expect(metrics.statusCounts[TrailerStatus.available], 1);
    expect(metrics.statusCounts[TrailerStatus.blocked], 0);
  });

  test('Monatswerte zaehlen nur aktive und abgeschlossene Vertraege', () {
    expect(metrics.months, hasLength(12));
    expect(metrics.months.last.month, DateTime(2026, 10));
    expect(metrics.months.last.rentals, 2);
    expect(metrics.months.last.revenueCents, 15000);
  });

  test('Offene Vertraege, Umsatz und Vorjahr', () {
    expect(metrics.openContracts, 2);
    expect(metrics.openValueCents, 8000);
    expect(metrics.revenueYearToDateCents, 17000);
    expect(metrics.rentalsYearToDate, 3);
    expect(metrics.revenuePreviousYearToDateCents, 7000);
    expect(metrics.rentalsPreviousYearToDate, 1);
  });

  test('Durchschnittliche Mietdauer und beliebteste Typen', () {
    expect(metrics.averageDurationDays, closeTo(7 / 3, 0.001));
    expect(metrics.popularTypes.first.typeName, 'Tieflader');
    expect(metrics.popularTypes.first.rentals, 3);
  });

  test('Auslastung im aktuellen Monat', () {
    final double expected = (2 + 4 + 1) / (2 * 31) * 100;
    expect(metrics.utilizationPercent, closeTo(expected, 0.1));
  });
}
