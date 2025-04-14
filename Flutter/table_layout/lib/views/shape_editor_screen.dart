import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_layout/models/shape_model.dart';
import 'package:table_layout/viewmodels/shape_viewmodel.dart';
import 'package:table_layout/views/shape_canvas.dart';

class ShapeEditorScreen extends ConsumerStatefulWidget {
  const ShapeEditorScreen({super.key});

  @override
  ConsumerState<ShapeEditorScreen> createState() => _ShapeEditorScreenState();
}

class _ShapeEditorScreenState extends ConsumerState<ShapeEditorScreen> {
  Offset? _dragStart;
  int? _resizeHandleIndex; // 크기 조정 핸들의 인덱스를 추적
  late ShapeModel _selectedShape;

  @override
  Widget build(BuildContext context) {
    final shapes = ref.watch(shapeListProvider);
    _selectedShape = shapes.firstWhere(
      (s) => s.isSelected,
      orElse: () => ShapeModel(
        id: '',
        type: '',
        x: 0,
        y: 0,
        width: 0,
        height: 0,
        color: 0,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shape Editor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box),
            onPressed: () {
              final newShape = ShapeModel(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                type: 'rectangle',
                x: 50,
                y: 50,
                width: 100,
                height: 100,
                color: Colors.blue.value,
              );
              ref.read(shapeListProvider.notifier).addShape(newShape);
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTapDown: (details) {
          final pos = details.localPosition;

          // 도형 선택 확인
          final shape = shapes.lastWhere(
            (s) =>
                pos.dx >= s.x &&
                pos.dx <= s.x + s.width &&
                pos.dy >= s.y &&
                pos.dy <= s.y + s.height,
            orElse: () => ShapeModel(
              id: '',
              type: '',
              x: 0,
              y: 0,
              width: 0,
              height: 0,
              color: 0,
            ),
          );

          if (shape.id.isNotEmpty) {
            ref.read(shapeListProvider.notifier).selectShape(shape.id);
          } else {
            ref.read(shapeListProvider.notifier).clearSelection();
          }
        },
        onPanStart: (details) {
          final pos = details.localPosition;

          // 도형을 선택한 경우
          final shape = shapes.firstWhere(
            (s) =>
                pos.dx >= s.x &&
                pos.dx <= s.x + s.width &&
                pos.dy >= s.y &&
                pos.dy <= s.y + s.height,
            orElse: () => ShapeModel(
              id: '',
              type: '',
              x: 0,
              y: 0,
              width: 0,
              height: 0,
              color: 0,
            ),
          );

          if (shape.id.isNotEmpty) {
            ref.read(shapeListProvider.notifier).selectShape(shape.id);
            _dragStart = pos;
            _resizeHandleIndex = _getResizeHandleIndex(pos); // 핸들 인덱스 설정
          }
        },
        onPanUpdate: (details) {
          if (_selectedShape.id.isEmpty || _dragStart == null) return;
          final delta = details.localPosition - _dragStart!;

          // 크기 조정 핸들이 선택되었을 때 크기 조정
          if (_resizeHandleIndex != null) {
            _resizeShape(delta);
          } else {
            // 도형 이동
            ref.read(shapeListProvider.notifier).moveShape(_selectedShape.id, delta.dx, delta.dy);
          }
          _dragStart = details.localPosition;
        },
        onPanEnd: (_) {
          _dragStart = null;
          _resizeHandleIndex = null; // 크기 조정 핸들 해제
        },
        child: CustomPaint(
          painter: ShapeCanvas(shapes),
          child: Container(),
        ),
      ),
    );
  }

  // 위치를 통해 크기 조정 핸들 인덱스를 찾는 메소드
  int? _getResizeHandleIndex(Offset position) {
    final handleSize = 10.0;
    final shape = _selectedShape;

    final handlePositions = [
      Offset(shape.x, shape.y), // 왼쪽 위
      Offset(shape.x + shape.width / 2, shape.y), // 상단 중간
      Offset(shape.x + shape.width, shape.y), // 오른쪽 위
      Offset(shape.x, shape.y + shape.height / 2), // 왼쪽 중간
      Offset(shape.x + shape.width, shape.y + shape.height / 2), // 오른쪽 중간
      Offset(shape.x, shape.y + shape.height), // 왼쪽 아래
      Offset(shape.x + shape.width / 2, shape.y + shape.height), // 하단 중간
      Offset(shape.x + shape.width, shape.y + shape.height), // 오른쪽 아래
    ];

    for (int i = 0; i < handlePositions.length; i++) {
      if ((position - handlePositions[i]).distance <= handleSize) {
        return i; // 핸들이 선택되었을 때 그 인덱스를 반환
      }
    }
    return null; // 핸들이 선택되지 않았을 경우
  }

  // // 크기 조정을 수행하는 메소드
  // void _resizeShape(Offset delta) {
  //   final shape = _selectedShape;
  //   double newWidth = shape.width;
  //   double newHeight = shape.height;

  //   final dx = delta.dx;
  //   final dy = delta.dy;

  //   // 선택된 핸들에 따라 크기 변경
  //   switch (_resizeHandleIndex) {
  //     case 0: // 왼쪽 위 핸들
  //       newWidth = shape.width - dx;
  //       newHeight = shape.height - dy;
  //       break;
  //     case 1: // 상단 중간 핸들
  //       newHeight = shape.height - dy;
  //       break;
  //     case 2: // 오른쪽 위 핸들
  //       newWidth = shape.width + dx;
  //       newHeight = shape.height - dy;
  //       break;
  //     case 3: // 왼쪽 중간 핸들
  //       newWidth = shape.width - dx;
  //       break;
  //     case 4: // 오른쪽 중간 핸들
  //       newWidth = shape.width + dx;
  //       break;
  //     case 5: // 왼쪽 아래 핸들
  //       newWidth = shape.width - dx;
  //       newHeight = shape.height + dy;
  //       break;
  //     case 6: // 하단 중간 핸들
  //       newHeight = shape.height + dy;
  //       break;
  //     case 7: // 오른쪽 아래 핸들
  //       newWidth = shape.width + dx;
  //       newHeight = shape.height + dy;
  //       break;
  //   }

  //   // 크기 조정된 값이 일정 범위 내에서만 유효하도록 처리
  //   if (newWidth > 10 && newHeight > 10) {
  //     ref.read(shapeListProvider.notifier).updateShape(
  //       shape.id,
  //       shape.copyWith(
  //         width: newWidth,
  //         height: newHeight,
  //       ),
  //     );
  //   }
  // }
  // void _resizeShape(Offset delta) {
  //   final shape = _selectedShape;
    
  //   // 더 민감하게 크기 변화 적용
  //   const sensitivity = 5.0; // delta 값에 곱할 민감도 설정
  //   double newWidth = shape.width;
  //   double newHeight = shape.height;

  //   final dx = delta.dx * sensitivity;
  //   final dy = delta.dy * sensitivity;

  //   // 크기 조정 핸들에 따라 크기 변경
  //   switch (_resizeHandleIndex) {
  //     case 0: // 왼쪽 위 핸들
  //       newWidth = shape.width - dx;
  //       newHeight = shape.height - dy;
  //       break;
  //     case 1: // 상단 중간 핸들
  //       newHeight = shape.height - dy;
  //       break;
  //     case 2: // 오른쪽 위 핸들
  //       newWidth = shape.width + dx;
  //       newHeight = shape.height - dy;
  //       break;
  //     case 3: // 왼쪽 중간 핸들
  //       newWidth = shape.width - dx;
  //       break;
  //     case 4: // 오른쪽 중간 핸들
  //       newWidth = shape.width + dx;
  //       break;
  //     case 5: // 왼쪽 아래 핸들
  //       newWidth = shape.width - dx;
  //       newHeight = shape.height + dy;
  //       break;
  //     case 6: // 하단 중간 핸들
  //       newHeight = shape.height + dy;
  //       break;
  //     case 7: // 오른쪽 아래 핸들
  //       newWidth = shape.width + dx;
  //       newHeight = shape.height + dy;
  //       break;
  //   }

  //   // 크기 조정된 값이 일정 범위 내에서만 유효하도록 처리
  //   if (newWidth > 10 && newHeight > 10) {
  //     ref.read(shapeListProvider.notifier).updateShape(
  //       shape.id,
  //       shape.copyWith(
  //         width: newWidth,
  //         height: newHeight,
  //       ),
  //     );
  //   }
  // }
  void _resizeShape(Offset delta) {
    final shape = _selectedShape;

    // 더 민감하게 크기 변화 적용
    const sensitivity = 5.0; // delta 값에 곱할 민감도 설정
    double x = shape.x;
    double y = shape.y;
    double width = shape.width;
    double height = shape.height;

    final dx = delta.dx * sensitivity;
    final dy = delta.dy * sensitivity;

    // 크기 조정 핸들에 따라 크기 및 위치 변경
    switch (_resizeHandleIndex) {
      case 0: // 왼쪽 위 핸들 (top-left)
        x += dx;
        y += dy;
        width -= dx;
        height -= dy;
        break;
      case 1: // 상단 중간 핸들 (top-center)
        y += dy;
        height -= dy;
        break;
      case 2: // 오른쪽 위 핸들 (top-right)
        width += dx;
        y += dy;
        height -= dy;
        break;
      case 3: // 왼쪽 중간 핸들 (center-left)
        x += dx;
        width -= dx;
        break;
      case 4: // 오른쪽 중간 핸들 (center-right)
        width += dx;
        break;
      case 5: // 왼쪽 아래 핸들 (bottom-left)
        x += dx;
        width -= dx;
        height += dy;
        break;
      case 6: // 하단 중간 핸들 (bottom-center)
        height += dy;
        break;
      case 7: // 오른쪽 아래 핸들 (bottom-right)
        width += dx;
        height += dy;
        break;
    }

    // 크기 조정된 값이 일정 범위 내에서만 유효하도록 처리
    if (width > 10 && height > 10) {
      ref.read(shapeListProvider.notifier).updateShape(
        shape.id,
        shape.copyWith(
          x: x,
          y: y,
          width: width,
          height: height,
        ),
      );
    }
  }

}





// // 상단 import 추가
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:table_layout/models/shape_model.dart';
// import 'package:table_layout/viewmodels/shape_viewmodel.dart';
// import 'package:table_layout/views/shape_canvas.dart';

// class ShapeEditorScreen extends ConsumerStatefulWidget {
//   const ShapeEditorScreen({super.key});

//   @override
//   ConsumerState<ShapeEditorScreen> createState() => _ShapeEditorScreenState();
// }

// class _ShapeEditorScreenState extends ConsumerState<ShapeEditorScreen> {
//   Offset? _dragStart;

//   @override
//   Widget build(BuildContext context) {
//     final shapes = ref.watch(shapeListProvider);
//     final selectedShape = shapes.firstWhere(
//       (s) => s.isSelected,
//       orElse: () => ShapeModel(
//         id: '',
//         type: '',
//         x: 0,
//         y: 0,
//         width: 0,
//         height: 0,
//         color: 0,
//       ),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Shape Editor'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add_box),
//             onPressed: () {
//               final newShape = ShapeModel(
//                 id: DateTime.now().millisecondsSinceEpoch.toString(),
//                 type: 'rectangle',
//                 x: 50,
//                 y: 50,
//                 width: 100,
//                 height: 100,
//                 color: Colors.blue.value,
//               );
//               ref.read(shapeListProvider.notifier).addShape(newShape);
//             },
//           ),
//         ],
//       ),
//       body: GestureDetector(
//         onTapDown: (details) {
//           final pos = details.localPosition;
//           final shape = shapes.lastWhere(
//             (s) =>
//                 pos.dx >= s.x &&
//                 pos.dx <= s.x + s.width &&
//                 pos.dy >= s.y &&
//                 pos.dy <= s.y + s.height,
//             orElse: () => ShapeModel(
//               id: '',
//               type: '',
//               x: 0,
//               y: 0,
//               width: 0,
//               height: 0,
//               color: 0,
//             ),
//           );

//           if (shape.id.isNotEmpty) {
//             ref.read(shapeListProvider.notifier).selectShape(shape.id);
//           } else {
//             ref.read(shapeListProvider.notifier).clearSelection();
//           }
//         },
//         onPanStart: (details) {
//           final pos = details.localPosition;
//           final shape = shapes.lastWhere(
//             (s) =>
//                 pos.dx >= s.x &&
//                 pos.dx <= s.x + s.width &&
//                 pos.dy >= s.y &&
//                 pos.dy <= s.y + s.height,
//             orElse: () => ShapeModel(
//               id: '',
//               type: '',
//               x: 0,
//               y: 0,
//               width: 0,
//               height: 0,
//               color: 0,
//             ),
//           );

//           if (shape.id.isNotEmpty) {
//             ref.read(shapeListProvider.notifier).selectShape(shape.id);
//             _dragStart = pos;
//           }
//         },
//         onPanUpdate: (details) {
//           if (selectedShape.id.isEmpty || _dragStart == null) return;
//           final delta = details.delta;
//           ref
//               .read(shapeListProvider.notifier)
//               .moveShape(selectedShape.id, delta.dx, delta.dy);
//         },
//         onPanEnd: (_) {
//           _dragStart = null;
//         },
//         child: CustomPaint(
//           painter: ShapeCanvas(shapes),
//           child: Container(),
//         ),
//       ),
//     );
//   }
// }
