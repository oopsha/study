import 'package:flutter/material.dart';

import '../columns/data_grid_column.dart';
import '../rows/data_grid_row.dart';
import '../render/header_view.dart';
import '../render/body_view.dart';
import 'data_grid_controller.dart';
import 'data_grid_theme.dart';

class DataGrid extends StatefulWidget {
  final List<DataGridColumn> columns;
  final List<DataGridRow> rows;
  final DataGridController? controller;
  final DataGridTheme theme;

  const DataGrid({
    super.key,
    required this.columns,
    required this.rows,
    this.controller,
    this.theme = const DataGridTheme(),
  });

  @override
  State<DataGrid> createState() => _DataGridState();
}

class _DataGridState extends State<DataGrid> {
  late final DataGridController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? DataGridController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderView(columns: widget.columns, theme: widget.theme),
        Expanded(
          child: BodyView(
            columns: widget.columns,
            rows: widget.rows,
            controller: _controller,
            theme: widget.theme,
          ),
        ),
      ],
    );
  }
}
