import 'dart:math' as math;

import '../../../data/models/enums.dart';
import '../../../data/models/rental_contract.dart';
import '../../../data/models/trailer.dart';

class MonthFigure {
  const MonthFigure({
    required this.month,
    required this.rentals,
    required this.revenueCents,
  });

  final DateTime month;
  final int rentals;
  final int revenueCents;
}

class TypeFigure {
  const TypeFigure({required this.typeName, required this.rentals});

  final String typeName;
  final int rentals;
}

class DashboardMetrics {
  const DashboardMetrics({
    required this.statusCounts,
    required this.utilizationPercent,
    required this.months,
    required this.openContracts,
    required this.openValueCents,
    required this.revenueYearToDateCents,
    required this.revenuePreviousYearToDateCents,
    required this.rentalsYearToDate,
    required this.rentalsPreviousYearToDate,
    required this.averageDurationDays,
    required this.popularTypes,
  });

  final Map<TrailerStatus, int> statusCounts;
  final double utilizationPercent;
  final List<MonthFigure> months;
  final int openContracts;
  final int openValueCents;
  final int revenueYearToDateCents;
  final int revenuePreviousYearToDateCents;
  final int rentalsYearToDate;
  final int rentalsPreviousYearToDate;
  final double averageDurationDays;
  final List<TypeFigure> popularTypes;

  static bool isRealized(RentalContract contract) =>
      contract.status == ContractStatus.active ||
      contract.status == ContractStatus.completed;

  static DashboardMetrics compute({
    required List<Trailer> trailers,
    required List<RentalContract> contracts,
    required DateTime now,
  }) {
    final List<Trailer> fleet = trailers
        .where((Trailer t) => !t.isArchived)
        .toList();
    final Map<TrailerStatus, int> statusCounts = <TrailerStatus, int>{
      for (final TrailerStatus status in TrailerStatus.values)
        status: fleet.where((Trailer t) => t.status == status).length,
    };

    final List<RentalContract> realized = contracts.where(isRealized).toList();

    final List<MonthFigure> months = <MonthFigure>[
      for (int offset = 11; offset >= 0; offset--)
        _monthFigure(DateTime(now.year, now.month - offset), realized),
    ];

    final List<RentalContract> open = contracts
        .where((RentalContract c) => c.status.blocksTrailer)
        .toList();

    final DateTime yearStart = DateTime(now.year);
    final DateTime previousYearStart = DateTime(now.year - 1);
    final DateTime previousNow = DateTime(
      now.year - 1,
      now.month,
      now.day,
      now.hour,
      now.minute,
    );
    final List<RentalContract> thisYear = realized
        .where((RentalContract c) => _within(c.startAt, yearStart, now))
        .toList();
    final List<RentalContract> previousYear = realized
        .where(
          (RentalContract c) =>
              _within(c.startAt, previousYearStart, previousNow),
        )
        .toList();

    final List<RentalContract> completed = contracts
        .where((RentalContract c) => c.status == ContractStatus.completed)
        .toList();
    final double averageDays = completed.isEmpty
        ? 0
        : completed
                  .map((RentalContract c) => c.duration.inMinutes / 1440)
                  .reduce((double a, double b) => a + b) /
              completed.length;

    final Map<int, Trailer> trailersById = <int, Trailer>{
      for (final Trailer trailer in trailers) trailer.id: trailer,
    };
    final Map<String, int> typeCounts = <String, int>{};
    for (final RentalContract contract in realized) {
      final String? typeName = trailersById[contract.trailerId]?.type.name;
      if (typeName != null) {
        typeCounts[typeName] = (typeCounts[typeName] ?? 0) + 1;
      }
    }
    final List<TypeFigure> popularTypes =
        typeCounts.entries
            .map(
              (MapEntry<String, int> entry) =>
                  TypeFigure(typeName: entry.key, rentals: entry.value),
            )
            .toList()
          ..sort((TypeFigure a, TypeFigure b) => b.rentals - a.rentals);

    return DashboardMetrics(
      statusCounts: statusCounts,
      utilizationPercent: _utilization(fleet.length, contracts, now),
      months: months,
      openContracts: open.length,
      openValueCents: _sum(open),
      revenueYearToDateCents: _sum(thisYear),
      revenuePreviousYearToDateCents: _sum(previousYear),
      rentalsYearToDate: thisYear.length,
      rentalsPreviousYearToDate: previousYear.length,
      averageDurationDays: averageDays,
      popularTypes: popularTypes.take(5).toList(),
    );
  }

  static MonthFigure _monthFigure(
    DateTime month,
    List<RentalContract> realized,
  ) {
    final DateTime next = DateTime(month.year, month.month + 1);
    final List<RentalContract> inMonth = realized
        .where(
          (RentalContract c) =>
              !c.startAt.isBefore(month) && c.startAt.isBefore(next),
        )
        .toList();
    return MonthFigure(
      month: month,
      rentals: inMonth.length,
      revenueCents: _sum(inMonth),
    );
  }

  static double _utilization(
    int fleetSize,
    List<RentalContract> contracts,
    DateTime now,
  ) {
    if (fleetSize == 0) {
      return 0;
    }
    final DateTime monthStart = DateTime(now.year, now.month);
    final DateTime monthEnd = DateTime(now.year, now.month + 1);
    double bookedMinutes = 0;
    for (final RentalContract contract in contracts) {
      if (contract.status == ContractStatus.cancelled) {
        continue;
      }
      final int start = math.max(
        contract.startAt.millisecondsSinceEpoch,
        monthStart.millisecondsSinceEpoch,
      );
      final int end = math.min(
        contract.endAt.millisecondsSinceEpoch,
        monthEnd.millisecondsSinceEpoch,
      );
      if (end > start) {
        bookedMinutes += (end - start) / 60000;
      }
    }
    final double capacityMinutes =
        fleetSize * monthEnd.difference(monthStart).inMinutes.toDouble();
    return math.min(100, bookedMinutes / capacityMinutes * 100);
  }

  static bool _within(DateTime value, DateTime from, DateTime until) {
    return !value.isBefore(from) && !value.isAfter(until);
  }

  static int _sum(List<RentalContract> contracts) {
    return contracts.fold<int>(
      0,
      (int total, RentalContract c) => total + c.priceCents,
    );
  }
}
