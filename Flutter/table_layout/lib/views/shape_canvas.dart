import 'package:flutter/material.dart';
import 'package:table_layout/models/shape_model.dart';

// class ShapeCanvas extends CustomPainter {
//   final List<ShapeModel> shapes;

//   ShapeCanvas(this.shapes);

//   @override
//   void paint(Canvas canvas, Size size) {
//     for (var shape in shapes) {
//       final paint = Paint()
//         ..color = Color(shape.color)
//         ..style = PaintingStyle.fill;

//       final rect = Rect.fromLTWH(shape.x, shape.y, shape.width, shape.height);
//       canvas.drawRect(rect, paint);

//       // 선택된 도형이면 테두리 그리기
//       if (shape.isSelected) {
//         final border = Paint()
//           ..color = Colors.black
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = 2;
//         canvas.drawRect(rect, border);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }





class ShapeCanvas extends CustomPainter {
  final List<ShapeModel> shapes;

  ShapeCanvas(this.shapes);

  @override
  void paint(Canvas canvas, Size size) {
    for (var shape in shapes) {
      final paint = Paint()
        ..color = Color(shape.color)
        ..style = PaintingStyle.fill;

      final rect = Rect.fromLTWH(shape.x, shape.y, shape.width, shape.height);
      canvas.drawRect(rect, paint);

      // 선택된 도형이면 테두리 그리기
      if (shape.isSelected) {
        final border = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        canvas.drawRect(rect, border);

        // 크기 조정 핸들 그리기 (8방향)
        _drawResizeHandles(canvas, shape);
      }
    }
  }

  void _drawResizeHandles(Canvas canvas, ShapeModel shape) {
    final handleSize = 10.0;

    // 8개의 핸들 위치 (모서리 + 중간점)
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

    final paint = Paint()..color = Colors.blue;

    for (var position in handlePositions) {
      canvas.drawCircle(position, handleSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
