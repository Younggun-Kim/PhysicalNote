import 'package:flutter/material.dart';

import '../theme/theme.dart';

extension BulidContextTextThemeExt on BuildContext {
  CustomBoxShadowTheme get boxShadowTheme => Theme.of(this).boxShadowTheme;
}

extension ThemeDataEx on ThemeData {
  CustomBoxShadowTheme get boxShadowTheme => CustomBoxShadowTheme();
}
