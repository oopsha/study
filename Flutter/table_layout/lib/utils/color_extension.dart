import 'package:flutter/material.dart';

/// Color 클래스에 HEX 문자열 변환 기능을 확장합니다.
extension ColorExtension on Color {
  /// 알파(투명도)를 제외한 HEX 색상 문자열을 반환합니다.
  ///
  /// 반환 형식: `#rrggbb` (예: `#ffa500`)
  String toHex() => '#${toARGB32().toRadixString(16).substring(2)}';

  /// 알파(투명도)를 포함한 HEX 색상 문자열을 반환합니다.
  ///
  /// 반환 형식: `#aarrggbb` (예: `#ffffa500`)
  String toHexWithAlpha() =>
      '#${toARGB32().toRadixString(16).padLeft(8, '0')}';

  /// HEX 문자열로부터 Color 객체를 생성합니다.
  ///
  /// 지원 형식: `#rrggbb`, `#aarrggbb`, `rrggbb`, `aarrggbb`
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    String hex = hexString.replaceFirst('#', '').toLowerCase();

    // rrggbb 형식이면 앞에 ff(alpha) 추가
    if (hex.length == 6) {
      buffer.write('ff');
    } else if (hex.length == 8) {
      // 이미 alpha 포함됨
    } else {
      throw FormatException('HEX 색상 형식이 올바르지 않습니다: $hexString');
    }

    buffer.write(hex);
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}





// import 'package:flutter/material.dart';

// /// Color 클래스에 HEX 문자열 변환 기능을 확장합니다.
// extension ColorHexExtension on Color {
//   /// 알파(투명도)를 제외한 HEX 색상 문자열을 반환합니다.
//   ///
//   /// 반환 형식: `#rrggbb` (예: `#ffa500`)
//   String toHex() => '#${toARGB32().toRadixString(16).substring(2)}';

//   /// 알파(투명도)를 포함한 HEX 색상 문자열을 반환합니다.
//   ///
//   /// 반환 형식: `#aarrggbb` (예: `#ffffa500`)
//   String toHexWithAlpha() => '#${toARGB32().toRadixString(16).padLeft(8, '0')}';
// }
