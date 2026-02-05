import 'package:flutter/material.dart';

import '../columns/data_grid_column.dart';
import '../grid/data_grid_controller.dart';
import '../grid/data_grid_theme.dart';
import '../rows/data_grid_row.dart';
import 'cell_view.dart';

class BodyView extends StatelessWidget {
  final List<DataGridColumn> columns;
  final List<DataGridRow> rows;
  final DataGridController controller;
  final DataGridTheme theme;

  const BodyView({
    super.key,
    required this.columns,
    required this.rows,
    required this.controller,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rows.length,
      itemBuilder: (context, rowIndex) {
        final row = rows[rowIndex];

        return GestureDetector(
          onTap: () => controller.selectRow(rowIndex),
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final selected = controller.selectedRowIndex == rowIndex;

              return Container(
                height: theme.rowHeight,
                color: selected ? theme.selectedColor : null,
                child: Row(
                  children: List.generate(columns.length, (colIndex) {
                    return CellView(
                      width: columns[colIndex].width,
                      value: row.cells[colIndex].value,
                    );
                  }),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
