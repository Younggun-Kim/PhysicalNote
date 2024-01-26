
import 'package:flutter/material.dart';

/// Border Thumb Shape.
class BorderThumbShape extends RoundSliderThumbShape {
  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        bool isDiscrete = false,
        TextPainter? labelPainter,
        RenderBox? parentBox,
        SliderThemeData? sliderTheme,
        TextDirection? textDirection,
        double? value,
        double? textScaleFactor,
        Size? sizeWithOverflow}) {
    final Canvas canvas = context.canvas;
    const double radius = 12;
    final Paint paint = Paint()
      ..color = sliderTheme!.thumbColor!
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paint);

    final Paint borderPaint = Paint()
      ..color = Colors.white // 테두리의 색상
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0; // 테두리의 두께

    canvas.drawCircle(center, radius, borderPaint);
  }
}
