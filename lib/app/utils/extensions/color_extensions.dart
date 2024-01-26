import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/colors/color_res.dart';

class HexColor extends Color {
  static int _getColorFromHex(String? hexColor, Color defaultColor) {
    if (hexColor == null) {
      return Colors.transparent
          .value; // You can change this to another default color if needed
    }
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor({
    required String? hexColor,
    Color defaultColor = ColorRes.disable,
  }) : super(_getColorFromHex(hexColor, defaultColor));
}
