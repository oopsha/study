import 'package:flutter/material.dart';

class DataGridColumn {
  final String title;
  final double width;
  final Widget Function(dynamic value)? renderer;

  const DataGridColumn({
    required this.title,
    required this.width,
    this.renderer,
  });
}
