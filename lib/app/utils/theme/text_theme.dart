import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/colors/color_res.dart';

class CustomTextTheme extends TextTheme {
  @override
  TextStyle? get headlineLarge => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: ColorRes.fontBlack,
        height: 1.6,
        letterSpacing: -0.5,
      );

  @override
  TextStyle? get headlineMedium => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: ColorRes.fontBlack,
        height: 1.6,
        letterSpacing: -0.5,
      );

  @override
  TextStyle? get headlineSmall => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: ColorRes.fontBlack,
        height: 1.6,
        letterSpacing: -0.5,
      );

  @override
  TextStyle? get bodyLarge => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ColorRes.fontBlack,
        height: 1.6,
        letterSpacing: -0.5,
      );

  @override
  TextStyle? get bodyMedium => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: ColorRes.fontBlack,
        height: 1.6,
        letterSpacing: -0.5,
      );

  @override
  TextStyle? get bodySmall => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: ColorRes.fontBlack,
        height: 1.6,
        letterSpacing: -0.5,
      );
}

extension CustomTextThemeEx on TextTheme {
  TextStyle? getBodyLarge(bool isBold) {
    return isBold ? bodyLargeBold : bodyLarge;
  }

  TextStyle? getBodyMedium(bool isBold) {
    return isBold ? bodyMediumBold : bodyMedium;
  }

  TextStyle? getBodySmall(bool isBold) {
    return isBold ? bodySmallBold : bodySmall;
  }

  TextStyle? get bodyLargeBold => bodyLarge?.copyWith(
        fontWeight: FontWeight.w700,
      );

  TextStyle? get bodyMediumBold => bodyMedium?.copyWith(
        fontWeight: FontWeight.w700,
      );

  TextStyle? get bodySmallBold => bodySmall?.copyWith(
        fontWeight: FontWeight.w700,
      );
}
