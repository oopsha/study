import 'package:flutter/foundation.dart';

class DataGridController extends ChangeNotifier {
  int? selectedRowIndex;

  void selectRow(int index) {
    selectedRowIndex = index;
    notifyListeners();
  }
}
