import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/utils/theme/text_theme.dart';

class CustomTheme {
  const CustomTheme();

  static ThemeData get theme {
    return ThemeData(
      fontFamily: 'NotoSans',
      textTheme: CustomTextTheme(),
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

