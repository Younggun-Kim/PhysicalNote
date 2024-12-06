import 'package:flutter/material.dart';

class CustomBoxShadowTheme {
  CustomBoxShadowTheme();

  /// blur - 8
  List<BoxShadow> get md {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 0,
        blurRadius: 8,
        offset: const Offset(0, 2),
        blurStyle: BlurStyle.normal,
      ),
    ];
  }

  /// blur - 8 bold
  List<BoxShadow> get mdBold {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.25),
        spreadRadius: 0,
        blurRadius: 8,
        offset: const Offset(0, 2),
        blurStyle: BlurStyle.normal,
      ),
    ];
  }

  /// blur - 10
  List<BoxShadow> get lg {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        spreadRadius: 0,
        blurRadius: 10,
        offset: const Offset(0, 2),
        blurStyle: BlurStyle.normal,
      ),
    ];
  }

  /// blur - 10, bold
  List<BoxShadow> get lgBold {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.25),
        spreadRadius: 0,
        blurRadius: 10,
        offset: const Offset(0, 2),
        blurStyle: BlurStyle.normal,
      ),
    ];
  }
}
