import 'package:flutter/material.dart';

import '../columns/data_grid_column.dart';
import '../grid/data_grid_theme.dart';

class HeaderView extends StatelessWidget {
  final List<DataGridColumn> columns;
  final DataGridTheme theme;

  const HeaderView({
    super.key,
    required this.columns,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.headerColor,
      height: theme.rowHeight,
      child: Row(
        children: columns.map((c) {
          return SizedBox(
            width: c.width,
            child: Center(child: Text(c.title)),
          );
        }).toList(),
      ),
    );
  }
}
