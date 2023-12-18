import 'package:flutter/material.dart';

/// 컬러 리소스.
class ColorRes {
  /// 앱 테마 컬러.
  static final primarySwatch = _createMaterialColor(primary);

  /// 클릭 오버레이 컬러.
  static final clickOverlayColor = Colors.black.withOpacity(0.1);

  /// 딤 컬러.
  static final dimmed = Colors.black.withOpacity(0.7);

  /// 0xffffffff
  static const white = Color(0xffffffff);

  /// 0xffa5ed2e.
  static const primary = Color(0xffa5ed2e);

  /// 0xffc1c1c1.
  static const disable = Color(0xffc1c1c1);

  /// 구분선.
  static const divider = Color(0xffe5e6e6);

  /// 0xffdff5bc.
  static const background = Color(0xffdff5bc);

  /// 0xff8dbe3d.
  static const border = Color(0xff8dbe3d);

  /// 0xffDD3E4D
  static const error = Color(0xffDD3E4D);

  /// 0xff9f9f9f.
  static const borderDeselect = Color(0xff9f9f9f);

  /// disabl.
  static const borderWhite = disable;

  /// 0xff000000.
  static const fontBlack = Color(0xff000000);

  /// 0xffff0000.
  static const fontError = Color(0xffff0000);

  /// disabl.
  static const fontDisable = disable;

  /// 0xff6e4ca0.
  static const wellness1 = Color(0xff6e4ca0);

  /// 0xff4d73ba.
  static const wellness2 = Color(0xff4d73ba);

  /// 0xff40b049.
  static const wellness3 = Color(0xff40b049);

  /// 0xfff0ea0d.
  static const wellness4 = Color(0xfff0ea0d);

  /// 0xffffc808.
  static const wellness5 = Color(0xffffc808);

  /// 0xfff27c21.
  static const wellness6 = Color(0xfff27c21);

  /// 0xffe82e25.
  static const wellness7 = Color(0xffe82e25);

  /// 0xfffffef9. 매우 양호.
  static const urine1 = Color(0xfffffef9);

  /// 0xffe9efcd. 양호.
  static const urine2 = Color(0xffe9efcd);

  /// 0xffe6e68c. 적정.
  static const urine3 = Color(0xffe6e68c);

  /// 0xffe0dc56. 수분 섭취 요망.
  static const urine4 = Color(0xffe0dc56);

  /// 0xffe2da15. 수분 섭취 권장.
  static const urine5 = Color(0xffe2da15);

  /// 0xffd2a121. 수분 섭취 필요.
  static const urine6 = Color(0xffd2a121);

  /// 0xffc18d27. 수분 부족 위급.
  static const urine7 = Color(0xffc18d27);

  /// 0xff8dbe3d.
  static const intensity0 = Color(0xff8dbe3d);

  /// 0xffb7d487.
  static const intensity1 = Color(0xffb7d487);

  /// 0xfffbdd73.
  static const intensity2 = Color(0xfffbdd73);

  /// 0xffffc808.
  static const intensity3 = Color(0xffffc808);

  /// 0xfff27c21.
  static const intensity4 = Color(0xfff27c21);

  /// 0xffff0000.
  static const intensity5 = Color(0xffff0000);

  /// 0xff7c9f42.
  static const intensityLine0 = Color(0xff7c9f42);

  /// 0xff8dbe3d.
  static const intensityLine1 = Color(0xff8dbe3d);

  /// 0xffffc808.
  static const intensityLine2 = Color(0xffffc808);

  /// 0xffe2b000.
  static const intensityLine3 = Color(0xffe2b000);

  /// 0xffca6415.
  static const intensityLine4 = Color(0xffca6415);

  /// 0xffbb0404.
  static const intensityLine5 = Color(0xffbb0404);

  /// 0xfff7e0e2.
  static const risk0 = Color(0xfff7e0e2);

  /// 0xfff3aeb3.
  static const risk1 = Color(0xfff3aeb3);

  /// 0xffed636e.
  static const risk2 = Color(0xffed636e);

  /// 0xffe60012.
  static const risk3 = Color(0xffe60012);

  /// 0xff7230ff.
  static const hooperIndexGood = Color(0xff7230ff);

  /// 0xff7230ff.
  static const hooperIndexDanger = Color(0xffff0000);

  /// 0xff7230ff.
  static const hooperIndexWarning = Color(0xffffcd1d);

  /// 0xff7230ff.
  static const hooperIndexNormal = Color(0xff1ead2d);

  /// 0xff7B4DFF.
  static const homePhysicalPurple = Color(0xff7B4DFF);

  /// 0xff98999C.
  static const gray5 = Color(0xff98999C);

  /// 0xff222222.
  static const gray10 = Color(0xff222222);

  static MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
