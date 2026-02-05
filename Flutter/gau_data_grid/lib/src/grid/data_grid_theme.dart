import 'package:flutter/material.dart';

class DataGridTheme {
  final double rowHeight;
  final Color headerColor;
  final Color selectedColor;

  const DataGridTheme({
    this.rowHeight = 40,
    this.headerColor = Colors.grey,
    this.selectedColor = Colors.blueAccent,
  });
}
