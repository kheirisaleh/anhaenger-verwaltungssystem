import 'package:fluent_ui/fluent_ui.dart';

import '../app_colors.dart';
import '../app_icons.dart';
import '../app_spacing.dart';
import '../app_typography.dart';

class AppDataColumn<T> {
  const AppDataColumn({
    required this.label,
    required this.cellBuilder,
    this.flex = 1,
    this.isNumeric = false,
    this.sortValue,
  });

  final String label;
  final Widget Function(T item) cellBuilder;
  final int flex;
  final bool isNumeric;
  final Comparable<Object> Function(T item)? sortValue;
}

class AppDataTable<T> extends StatefulWidget {
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
  State<AppDataTable<T>> createState() => _AppDataTableState<T>();
}

class _AppDataTableState<T> extends State<AppDataTable<T>> {
  int? _sortColumn;
  bool _ascending = true;

  List<T> get _sortedRows {
    final int? index = _sortColumn;
    if (index == null || index >= widget.columns.length) {
      return widget.rows;
    }
    final Comparable<Object> Function(T item)? value =
        widget.columns[index].sortValue;
    if (value == null) {
      return widget.rows;
    }
    final List<T> sorted = List<T>.of(widget.rows)
      ..sort((T a, T b) {
        final int result = value(a).compareTo(value(b));
        return _ascending ? result : -result;
      });
    return sorted;
  }

  void _toggleSort(int index) {
    setState(() {
      if (_sortColumn == index) {
        _ascending = !_ascending;
      } else {
        _sortColumn = index;
        _ascending = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ValueChanged<T>? tap = widget.onRowTap;
    final List<T> rows = _sortedRows;
    final Widget list = ListView.builder(
      shrinkWrap: widget.shrinkWrap,
      physics: widget.shrinkWrap ? const NeverScrollableScrollPhysics() : null,
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
        mainAxisSize: widget.shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
        children: <Widget>[
          _buildHeader(),
          if (widget.shrinkWrap) list else Expanded(child: list),
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
          for (int i = 0; i < widget.columns.length; i++)
            Expanded(
              flex: widget.columns[i].flex,
              child: _buildHeaderCell(i, widget.columns[i]),
            ),
          if (widget.actionsBuilder != null)
            SizedBox(width: widget.actionsWidth),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(int index, AppDataColumn<T> column) {
    final bool isSorted = _sortColumn == index;
    final Widget label = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: Text(
            column.label,
            style: AppText.label,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (isSorted) ...<Widget>[
          const SizedBox(width: AppSpacing.xs),
          Icon(
            _ascending ? AppIcons.sortAscending : AppIcons.sortDescending,
            size: AppSizes.iconTiny,
            color: AppColors.textSecondary,
          ),
        ],
      ],
    );
    final Widget cell = _cell(label, isNumeric: column.isNumeric);
    if (column.sortValue == null) {
      return cell;
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _toggleSort(index),
      child: cell,
    );
  }

  Widget _buildCells(T item) {
    final List<Widget> Function(T item)? actions = widget.actionsBuilder;
    return Row(
      children: <Widget>[
        for (final AppDataColumn<T> column in widget.columns)
          Expanded(
            flex: column.flex,
            child: _cell(column.cellBuilder(item), isNumeric: column.isNumeric),
          ),
        if (actions != null)
          SizedBox(
            width: widget.actionsWidth,
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
  const AppTableText(
    this.text, {
    super.key,
    this.isMuted = false,
    this.color,
  });

  final String text;
  final bool isMuted;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final TextStyle base = isMuted ? AppText.bodyMuted : AppText.body;
    final Color? textColor = color;
    return Text(
      text,
      style: textColor == null ? base : base.copyWith(color: textColor),
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
