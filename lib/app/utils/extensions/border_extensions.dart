import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/colors/color_res.dart';

extension BorderExt on Border {
  /// 바텀 보더.
  static Border bottomBorder({
    Color color = ColorRes.disable,
    double width = 1.0,
  }) {
    return Border(
      bottom: BorderSide(
        color: color,
        width: width,
      ),
    );
  }
}
