import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/colors/color_res.dart';

class ColorUtils {

  // wellness를 Color로 변경
  static Color convertWellness(int wellness) {
    switch(wellness) {
      case 1:
        return ColorRes.wellness1;
      case 2:
        return ColorRes.wellness2;
      case 3:
        return ColorRes.wellness3;
      case 4:
        return ColorRes.wellness4;
      case 5:
        return ColorRes.wellness5;
      case 6:
        return ColorRes.wellness6;
      case 7:
        return ColorRes.wellness7;
      default:
        return ColorRes.disable;
    }
  }
}