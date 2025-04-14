import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: SafeArea(child: ShapeEditor())),
    );
  }
}

class ShapeEditor extends StatefulWidget {
  const ShapeEditor({super.key});

  @override
  State<ShapeEditor> createState() => _ShapeEditorState();
}

class _ShapeEditorState extends State<ShapeEditor> {
  Rect rect = const Rect.fromLTWH(100, 100, 200, 150);
  bool isDragging = false;
  Offset? dragStart;
  int? activeHandleIndex;

  final double handleSize = 12;
  Offset? _lastHoverPos;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      // onHover: _onHover,
      onHover: (event) => _onHover(event.position),
      cursor: _getCursor(),
      child: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: (_) {
          isDragging = false;
          activeHandleIndex = null;
          setState(() {});
        },
        child: CustomPaint(
          painter: ShapePainter(rect: rect, handleSize: handleSize),
          child: Container(),
        ),
      ),
    );
  }

  // void _onHover(PointerHoverEvent event) {
  //   _lastHoverPos = event.localPosition;
  //   setState(() {}); // 커서 변경 위해 상태 갱신
  // }
  void _onHover(Offset position) {
    _lastHoverPos = position;
    setState(() {});
  }

  MouseCursor _getCursor() {
    if (_lastHoverPos == null) return SystemMouseCursors.basic;

    for (int i = 0; i < 8; i++) {
      final handleCenter = _getHandleCenter(i);
      if ((_lastHoverPos! - handleCenter).distance <= handleSize) {
        return _handleCursor(i);
      }
    }

    if (rect.contains(_lastHoverPos!)) {
      return SystemMouseCursors.move;
    }

    return SystemMouseCursors.basic;
  }

  MouseCursor _handleCursor(int index) {
    switch (index) {
      case 0:
      case 4:
        return SystemMouseCursors.resizeUpLeftDownRight;
      case 2:
      case 6:
        return SystemMouseCursors.resizeUpRightDownLeft;
      case 1:
      case 5:
        return SystemMouseCursors.resizeUpDown;
      case 3:
      case 7:
        return SystemMouseCursors.resizeLeftRight;
      default:
        return SystemMouseCursors.basic;
    }
  }

  void _onPanStart(DragStartDetails details) {
    final pos = details.localPosition;
    for (int i = 0; i < 8; i++) {
      final handleCenter = _getHandleCenter(i);
      if ((pos - handleCenter).distance <= handleSize) {
        activeHandleIndex = i;
        return;
      }
    }
    if (rect.contains(pos)) {
      isDragging = true;
      dragStart = pos;
    }
  }

  // void _onPanUpdate(DragUpdateDetails details) {
  //   final delta = details.localPosition - details.previousLocalPosition;

  //   if (activeHandleIndex != null) {
  //     _resize(activeHandleIndex!, delta);
  //   } else if (isDragging && dragStart != null) {
  //     rect = rect.shift(delta);
  //   }
  //   setState(() {});
  // }
  void _onPanUpdate(DragUpdateDetails details) {
    final delta = details.delta;

    if (activeHandleIndex != null) {
      _resize(activeHandleIndex!, delta);
    } else if (isDragging && dragStart != null) {
      rect = rect.shift(delta);
    }
    setState(() {});
  }

  void _resize(int index, Offset delta) {
    double left = rect.left;
    double top = rect.top;
    double right = rect.right;
    double bottom = rect.bottom;

    switch (index) {
      case 0: // top-left
        left += delta.dx;
        top += delta.dy;
        break;
      case 1: // top-center
        top += delta.dy;
        break;
      case 2: // top-right
        right += delta.dx;
        top += delta.dy;
        break;
      case 3: // center-right
        right += delta.dx;
        break;
      case 4: // bottom-right
        right += delta.dx;
        bottom += delta.dy;
        break;
      case 5: // bottom-center
        bottom += delta.dy;
        break;
      case 6: // bottom-left
        left += delta.dx;
        bottom += delta.dy;
        break;
      case 7: // center-left
        left += delta.dx;
        break;
    }

    rect = Rect.fromLTRB(left, top, right, bottom);
  }

  Offset _getHandleCenter(int index) {
    switch (index) {
      case 0:
        return rect.topLeft;
      case 1:
        return Offset(rect.center.dx, rect.top);
      case 2:
        return rect.topRight;
      case 3:
        return Offset(rect.right, rect.center.dy);
      case 4:
        return rect.bottomRight;
      case 5:
        return Offset(rect.center.dx, rect.bottom);
      case 6:
        return rect.bottomLeft;
      case 7:
        return Offset(rect.left, rect.center.dy);
      default:
        return rect.center;
    }
  }
}

class ShapePainter extends CustomPainter {
  final Rect rect;
  final double handleSize;

  ShapePainter({required this.rect, required this.handleSize});

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()..color = Colors.orange;
    final strokePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRect(rect, fillPaint);
    canvas.drawRect(rect, strokePaint);

    final cx = rect.left + rect.width / 2;
    final cy = rect.top + rect.height / 2;

    final handles = [
      Offset(rect.left, rect.top),
      Offset(cx, rect.top),
      Offset(rect.right, rect.top),
      Offset(rect.right, cy),
      Offset(rect.right, rect.bottom),
      Offset(cx, rect.bottom),
      Offset(rect.left, rect.bottom),
      Offset(rect.left, cy),
    ];

    for (final handle in handles) {
      canvas.drawCircle(handle, handleSize / 2, Paint()..color = Colors.blue);
    }
  }

  @override
  bool shouldRepaint(covariant ShapePainter oldDelegate) => true;
}
