import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/design/app_colors.dart';
import '../../../core/design/app_icons.dart';
import '../../../core/design/app_spacing.dart';
import '../../../core/design/app_typography.dart';
import '../../../core/design/widgets/app_button.dart';
import '../../../core/design/widgets/app_card.dart';
import '../../../core/design/widgets/app_charts.dart';
import '../../../core/design/widgets/app_messages.dart';
import '../../../core/design/widgets/app_page_scaffold.dart';
import '../../../core/design/widgets/app_state_views.dart';
import '../../../core/formatting/app_formats.dart';
import '../../../data/models/enums.dart';
import '../../../data/models/rental_contract.dart';
import '../../../data/models/trailer.dart';
import '../../../data/repositories/trailer_repository.dart';
import '../../../shared/app_dependencies.dart';
import '../../../shared/file_dialogs.dart';
import '../application/dashboard_metrics.dart';
import 'today_tasks.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Stream<List<Trailer>>? _trailers;
  Stream<List<RentalContract>>? _contracts;
  DashboardMetrics? _latest;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppDependencies dependencies = AppScope.of(context);
    _trailers ??= dependencies.trailers.watchAll(
      query: const TrailerQuery(includeArchived: true),
    );
    _contracts ??= dependencies.contracts.watchAll();
  }

  @override
  Widget build(BuildContext context) {
    return AppPageScaffold(
      title: AppStrings.navDashboard,
      actions: <Widget>[
        AppButton(
          label: AppStrings.actionExport,
          icon: AppIcons.export,
          onPressed: () => _export(context),
        ),
      ],
      content: StreamBuilder<List<Trailer>>(
        stream: _trailers,
        builder: (BuildContext context, AsyncSnapshot<List<Trailer>> trailers) {
          return StreamBuilder<List<RentalContract>>(
            stream: _contracts,
            builder:
                (
                  BuildContext context,
                  AsyncSnapshot<List<RentalContract>> contracts,
                ) {
                  if (trailers.hasError || contracts.hasError) {
                    return const AppErrorState();
                  }
                  final List<Trailer>? trailerList = trailers.data;
                  final List<RentalContract>? contractList = contracts.data;
                  if (trailerList == null || contractList == null) {
                    return const AppLoadingState();
                  }
                  final DateTime now = DateTime.now();
                  final DashboardMetrics metrics = DashboardMetrics.compute(
                    trailers: trailerList,
                    contracts: contractList,
                    now: now,
                  );
                  _latest = metrics;
                  return _buildContent(metrics, contractList, now);
                },
          );
        },
      ),
    );
  }

  Widget _buildContent(
    DashboardMetrics metrics,
    List<RentalContract> contracts,
    DateTime now,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TodayTasks(contracts: contracts, now: now),
          const SizedBox(height: AppSpacing.lg),
          const Text(AppStrings.dashboardFleet, style: AppText.sectionTitle),
          const SizedBox(height: AppSpacing.sm),
          _tiles(<Widget>[
            AppStatTile(
              label: AppStrings.statusAvailable,
              value: '${metrics.statusCounts[TrailerStatus.available] ?? 0}',
              color: AppColors.statusAvailable,
            ),
            AppStatTile(
              label: AppStrings.statusRented,
              value: '${metrics.statusCounts[TrailerStatus.rented] ?? 0}',
              color: AppColors.statusRented,
            ),
            AppStatTile(
              label: AppStrings.statusMaintenance,
              value: '${metrics.statusCounts[TrailerStatus.maintenance] ?? 0}',
              color: AppColors.statusMaintenance,
            ),
            AppStatTile(
              label: AppStrings.statusBlocked,
              value: '${metrics.statusCounts[TrailerStatus.blocked] ?? 0}',
              color: AppColors.statusBlocked,
            ),
            AppStatTile(
              label: AppStrings.dashboardUtilization,
              value: AppFormats.percent(metrics.utilizationPercent),
              caption: AppStrings.dashboardThisMonth,
            ),
          ]),
          const SizedBox(height: AppSpacing.lg),
          const Text(AppStrings.dashboardFinance, style: AppText.sectionTitle),
          const SizedBox(height: AppSpacing.sm),
          _tiles(<Widget>[
            AppStatTile(
              label: AppStrings.dashboardRevenueYtd,
              value: AppFormats.currencyFromCents(
                metrics.revenueYearToDateCents,
              ),
              caption:
                  '${AppStrings.dashboardPreviousYear}: '
                  '${AppFormats.currencyFromCents(metrics.revenuePreviousYearToDateCents)}',
            ),
            AppStatTile(
              label: AppStrings.dashboardRentalsYtd,
              value: '${metrics.rentalsYearToDate}',
              caption:
                  '${AppStrings.dashboardPreviousYear}: '
                  '${metrics.rentalsPreviousYearToDate}',
            ),
            AppStatTile(
              label: AppStrings.dashboardOpenContracts,
              value: '${metrics.openContracts}',
              caption: AppFormats.currencyFromCents(metrics.openValueCents),
            ),
            AppStatTile(
              label: AppStrings.dashboardAverageDuration,
              value:
                  '${AppFormats.decimal(metrics.averageDurationDays)} '
                  '${AppStrings.days}',
            ),
          ]),
          const SizedBox(height: AppSpacing.lg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: AppCard(
                  title: AppStrings.dashboardRentalsPerMonth,
                  child: AppBarChart(
                    points: <AppChartPoint>[
                      for (final MonthFigure month in metrics.months)
                        AppChartPoint(
                          label: AppFormats.month(month.month),
                          value: month.rentals.toDouble(),
                          valueLabel: '${month.rentals}',
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: AppCard(
                  title: AppStrings.dashboardRevenuePerMonth,
                  child: AppLineChart(
                    points: <AppChartPoint>[
                      for (final MonthFigure month in metrics.months)
                        AppChartPoint(
                          label: AppFormats.month(month.month),
                          value: month.revenueCents.toDouble(),
                          valueLabel: AppFormats.currencyFromCents(
                            month.revenueCents,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            title: AppStrings.dashboardPopularTypes,
            child: metrics.popularTypes.isEmpty
                ? const Text(AppStrings.none, style: AppText.bodyMuted)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (final TypeFigure type in metrics.popularTypes)
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppSpacing.xs,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(type.typeName, style: AppText.body),
                              ),
                              Text(
                                '${type.rentals} ${AppStrings.rentals}',
                                style: AppText.bodyMuted,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _tiles(List<Widget> tiles) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        const double gap = AppSpacing.md;
        final int perRow = constraints.maxWidth > 900 ? tiles.length : 3;
        final double width =
            (constraints.maxWidth - gap * (perRow - 1)) / perRow;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: <Widget>[
            for (final Widget tile in tiles)
              SizedBox(width: width, child: tile),
          ],
        );
      },
    );
  }

  Future<void> _export(BuildContext context) async {
    final DashboardMetrics? metrics = _latest;
    if (metrics == null) {
      return;
    }
    final List<List<String>> rows = <List<String>>[
      <String>[AppStrings.dashboardReport, AppFormats.date(DateTime.now())],
      <String>[],
      <String>[
        AppStrings.dashboardMonth,
        AppStrings.rentals,
        AppStrings.dashboardRevenue,
      ],
      for (final MonthFigure month in metrics.months)
        <String>[
          AppFormats.month(month.month),
          '${month.rentals}',
          AppFormats.currencyFromCents(month.revenueCents),
        ],
      <String>[],
      <String>[AppStrings.dashboardFleet],
      for (final TrailerStatus status in TrailerStatus.values)
        <String>[status.label, '${metrics.statusCounts[status] ?? 0}'],
      <String>[
        AppStrings.dashboardUtilization,
        AppFormats.percent(metrics.utilizationPercent),
      ],
      <String>[],
      <String>[AppStrings.dashboardFinance],
      <String>[
        AppStrings.dashboardRevenueYtd,
        AppFormats.currencyFromCents(metrics.revenueYearToDateCents),
      ],
      <String>[
        '${AppStrings.dashboardRevenueYtd} ${AppStrings.dashboardPreviousYear}',
        AppFormats.currencyFromCents(metrics.revenuePreviousYearToDateCents),
      ],
      <String>[AppStrings.dashboardOpenContracts, '${metrics.openContracts}'],
      <String>[
        AppStrings.dashboardOpenValue,
        AppFormats.currencyFromCents(metrics.openValueCents),
      ],
      <String>[
        AppStrings.dashboardAverageDuration,
        '${AppFormats.decimal(metrics.averageDurationDays)} ${AppStrings.days}',
      ],
      <String>[],
      <String>[AppStrings.dashboardPopularTypes, AppStrings.rentals],
      for (final TypeFigure type in metrics.popularTypes)
        <String>[type.typeName, '${type.rentals}'],
    ];
    try {
      final File? file = await FileDialogs.saveCsv(
        AppStrings.exportReportFile,
        rows,
      );
      if (file != null && context.mounted) {
        AppMessages.success(
          context,
          '${AppStrings.exportDone} ${file.path}',
        );
      }
    } on FileSystemException {
      if (context.mounted) {
        AppMessages.error(context, AppStrings.errorFile);
      }
    }
  }
}
