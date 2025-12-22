import 'package:flutter/material.dart';

class CellView extends StatelessWidget {
  final double width;
  final dynamic value;

  const CellView({
    super.key,
    required this.width,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Center(child: Text('$value')),
    );
  }
}
