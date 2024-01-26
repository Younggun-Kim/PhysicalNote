import 'package:flutter/material.dart';

class CustomSliderTickMarkShape extends SliderTickMarkShape {
  @override
  Size getPreferredSize({
    required SliderThemeData sliderTheme,
    required bool isEnabled,
  }) {
    // Adjust the size of the tick mark as needed
    return Size(1.0, (sliderTheme.trackHeight ?? 10));
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required Animation<double> enableAnimation,
        required TextDirection textDirection,
        required Offset thumbCenter,
        required bool isEnabled,
      }) {
    final Paint paint = Paint()
      ..color = sliderTheme.inactiveTickMarkColor!
      ..strokeCap = StrokeCap.square
      ..strokeWidth = 1.0; // Adjust the stroke width as needed

    final height = sliderTheme.trackHeight ?? 10;
    context.canvas.drawLine(
      center.translate(0.0, height * -0.5),
      center.translate(0.0, height * 0.5),
      paint,
    );
  }
}
