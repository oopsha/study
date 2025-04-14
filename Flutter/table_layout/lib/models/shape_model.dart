class ShapeModel {
  final String id;
  final String type; // rectangle, circle 등
  final double x;
  final double y;
  final double width;
  final double height;
  final int color;
  final double strokeWidth;
  final bool isSelected;

  const ShapeModel({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.color,
    this.strokeWidth = 2.0,
    this.isSelected = false,
  });

  factory ShapeModel.fromJson(Map<String, dynamic> json) => ShapeModel(
        id: json['id'],
        type: json['type'],
        x: json['x'],
        y: json['y'],
        width: json['width'],
        height: json['height'],
        color: json['color'],
        strokeWidth: json['strokeWidth'] ?? 2.0,
        isSelected: json['isSelected'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'x': x,
        'y': y,
        'width': width,
        'height': height,
        'color': color,
        'strokeWidth': strokeWidth,
        'isSelected': isSelected,
      };

  ShapeModel copyWith({
    double? x,
    double? y,
    double? width,
    double? height,
    int? color,
    double? strokeWidth,
    bool? isSelected,
  }) {
    return ShapeModel(
      id: id,
      type: type,
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
