import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';

class CustomTheme {
  const CustomTheme();

  static ThemeData get theme {
    return ThemeData(
      fontFamily: 'NotoSans',
      progressIndicatorTheme: progressTheme,
    );
  }

  /// Indicator Theme
  static ProgressIndicatorThemeData get progressTheme {
    return const ProgressIndicatorThemeData(
      color: ColorRes.primary,
    );
  }
}

