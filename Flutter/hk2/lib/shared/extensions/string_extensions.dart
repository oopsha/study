import 'package:flutter/material.dart';

extension HexColor on String {
  Color toColor({Color fallbackColor = Colors.transparent}) {
    try {
      String hex = toUpperCase().replaceAll('#', '');

      // 3자리일 경우 6자리로 확장 (예: "ABC" → "AABBCC")
      if (hex.length == 3) {
        hex = hex.split('').map((c) => '$c$c').join();
      }

      // 6자리일 경우 불투명도 FF 추가
      if (hex.length == 6) {
        hex = 'FF$hex';
      }

      // 최종적으로 8자리인지 확인
      if (hex.length != 8 || !RegExp(r'^[0-9A-F]{8}$').hasMatch(hex)) {
        return fallbackColor;
      }

      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      return fallbackColor;
    }
  }
}
