import 'package:fluent_ui/fluent_ui.dart';

import '../app_colors.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppDataColumn<T> {
  const AppDataColumn({
    required this.label,
    required this.cellBuilder,
    this.flex = 1,
    this.isNumeric = false,
  });

  final String label;
  final Widget Function(T item) cellBuilder;
  final int flex;
  final bool isNumeric;
}

class AppDataTable<T> extends StatelessWidget {
  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onRowTap,
    this.actionsBuilder,
    this.actionsWidth = 120,
    this.shrinkWrap = false,
  });

  final List<AppDataColumn<T>> columns;
  final List<T> rows;
  final ValueChanged<T>? onRowTap;
  final List<Widget> Function(T item)? actionsBuilder;
  final double actionsWidth;
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final ValueChanged<T>? tap = onRowTap;
    final Widget list = ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      itemCount: rows.length,
      itemBuilder: (BuildContext context, int index) {
        final T item = rows[index];
        return _AppDataRow(
          onTap: tap == null ? null : () => tap(item),
          child: _buildCells(item),
        );
      },
    );
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
        children: <Widget>[
          _buildHeader(),
          if (shrinkWrap) list else Expanded(child: list),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: AppSizes.tableHeaderHeight,
      color: AppColors.background,
      child: Row(
        children: <Widget>[
          for (final AppDataColumn<T> column in columns)
            Expanded(
              flex: column.flex,
              child: _cell(
                Text(
                  column.label,
                  style: AppText.label,
                  overflow: TextOverflow.ellipsis,
                ),
                isNumeric: column.isNumeric,
              ),
            ),
          if (actionsBuilder != null) SizedBox(width: actionsWidth),
        ],
      ),
    );
  }

  Widget _buildCells(T item) {
    final List<Widget> Function(T item)? actions = actionsBuilder;
    return Row(
      children: <Widget>[
        for (final AppDataColumn<T> column in columns)
          Expanded(
            flex: column.flex,
            child: _cell(column.cellBuilder(item), isNumeric: column.isNumeric),
          ),
        if (actions != null)
          SizedBox(
            width: actionsWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions(item),
            ),
          ),
      ],
    );
  }

  Widget _cell(Widget child, {required bool isNumeric}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Align(
        alignment: isNumeric ? Alignment.centerRight : Alignment.centerLeft,
        child: child,
      ),
    );
  }
}

class AppTableText extends StatelessWidget {
  const AppTableText(this.text, {super.key, this.isMuted = false});

  final String text;
  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: isMuted ? AppText.bodyMuted : AppText.body,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}

class _AppDataRow extends StatefulWidget {
  const _AppDataRow({required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  State<_AppDataRow> createState() => _AppDataRowState();
}

class _AppDataRowState extends State<_AppDataRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: widget.onTap,
        child: Container(
          height: AppSizes.tableRowHeight,
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.background : AppColors.surface,
            border: const Border(top: BorderSide(color: AppColors.divider)),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
