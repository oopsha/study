import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_layout/models/shape_model.dart';


class ShapeViewModel extends Notifier<List<ShapeModel>> {
  @override
  List<ShapeModel> build() {
    return []; // 초기 도형 목록
  }

  void addShape(ShapeModel shape) {
    state = [...state, shape];
  }

  void updateShape(String id, ShapeModel updated) {
    state = [
      for (final shape in state)
        if (shape.id == id) updated else shape
    ];
  }

  void removeShape(String id) {
    state = state.where((s) => s.id != id).toList();
  }

  void clearSelection() {
    state = [
      for (final shape in state) shape.copyWith(isSelected: false)
    ];
  }

  void selectShape(String id) {
    state = [
      for (final shape in state)
        shape.copyWith(isSelected: shape.id == id)
    ];
  }

  void moveShape(String id, double dx, double dy) {
    final index = state.indexWhere((s) => s.id == id);
    if (index == -1) return;
    final shape = state[index];
    updateShape(
      id,
      shape.copyWith(x: shape.x + dx, y: shape.y + dy),
    );
  }
}

final shapeListProvider =
    NotifierProvider<ShapeViewModel, List<ShapeModel>>(ShapeViewModel.new);
