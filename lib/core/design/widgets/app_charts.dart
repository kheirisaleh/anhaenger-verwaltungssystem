import 'dart:math' as math;

import 'package:fluent_ui/fluent_ui.dart';

import '../app_colors.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppChartPoint {
  const AppChartPoint({
    required this.label,
    required this.value,
    required this.valueLabel,
  });

  final String label;
  final double value;
  final String valueLabel;
}

class AppBarChart extends StatelessWidget {
  const AppBarChart({super.key, required this.points, this.height = 180});

  final List<AppChartPoint> points;
  final double height;

  @override
  Widget build(BuildContext context) {
    final double maxValue = points.fold<double>(
      0,
      (double highest, AppChartPoint point) => math.max(highest, point.value),
    );
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          for (final AppChartPoint point in points)
            Expanded(
              child: Tooltip(
                message: '${point.label}: ${point.valueLabel}',
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        point.valueLabel,
                        style: AppText.caption,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Flexible(
                        child: FractionallySizedBox(
                          heightFactor: maxValue <= 0
                              ? 0.02
                              : math.max(point.value / maxValue, 0.02),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              borderRadius: BorderRadius.circular(
                                AppRadius.sm,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        point.label,
                        style: AppText.caption,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class AppLineChart extends StatelessWidget {
  const AppLineChart({super.key, required this.points, this.height = 180});

  final List<AppChartPoint> points;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: <Widget>[
          Expanded(
            child: CustomPaint(
              painter: _LinePainter(points),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: <Widget>[
              for (final AppChartPoint point in points)
                Expanded(
                  child: Tooltip(
                    message: '${point.label}: ${point.valueLabel}',
                    child: Text(
                      point.label,
                      style: AppText.caption,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  _LinePainter(this.points);

  final List<AppChartPoint> points;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) {
      return;
    }
    final double maxValue = points.fold<double>(
      0,
      (double highest, AppChartPoint point) => math.max(highest, point.value),
    );
    final double slot = size.width / points.length;
    final Paint gridPaint = Paint()
      ..color = AppColors.divider
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(0, size.height - 1),
      Offset(size.width, size.height - 1),
      gridPaint,
    );
    final List<Offset> offsets = <Offset>[
      for (int i = 0; i < points.length; i++)
        Offset(
          slot * i + slot / 2,
          maxValue <= 0
              ? size.height - 2
              : size.height -
                    2 -
                    (points[i].value / maxValue) * (size.height - 8),
        ),
    ];
    final Path path = Path()..moveTo(offsets.first.dx, offsets.first.dy);
    for (final Offset offset in offsets.skip(1)) {
      path.lineTo(offset.dx, offset.dy);
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.accent
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );
    final Paint dotPaint = Paint()..color = AppColors.accent;
    for (final Offset offset in offsets) {
      canvas.drawCircle(offset, 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_LinePainter oldDelegate) => oldDelegate.points != points;
}

class AppStatTile extends StatelessWidget {
  const AppStatTile({
    super.key,
    required this.label,
    required this.value,
    this.caption,
    this.color = AppColors.textPrimary,
  });

  final String label;
  final String value;
  final String? caption;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final String? text = caption;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(label, style: AppText.caption, maxLines: 1),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppText.sectionTitle.copyWith(color: color),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (text != null) ...<Widget>[
            const SizedBox(height: AppSpacing.xs),
            Text(text, style: AppText.caption, maxLines: 1),
          ],
        ],
      ),
    );
  }
}

class AppKeyValue extends StatelessWidget {
  const AppKeyValue({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: AppText.caption),
          Text(value, style: AppText.body),
        ],
      ),
    );
  }
}
