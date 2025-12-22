import 'package:flutter/material.dart';
import 'package:gau_data_grid/gau_data_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('GAU Data Grid')),
        body: DataGrid(
          columns: const [
            DataGridColumn(title: 'Name', width: 120),
            DataGridColumn(title: 'Age', width: 80),
          ],
          rows: const [
            DataGridRow([
              DataGridCell('Alice'),
              DataGridCell(20),
            ]),
            DataGridRow([
              DataGridCell('Bob'),
              DataGridCell(30),
            ]),
          ],
        ),
      ),
    );
  }
}
