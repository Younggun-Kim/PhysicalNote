import 'package:flutter/material.dart';

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final double currentValue;
  final Color borderColor;

  const CustomSliderThumbCircle({
    required this.thumbRadius,
    required this.currentValue,
    this.borderColor = Colors.white,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    Animation<double>? enableAnimation,
    bool? isDiscrete,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    /// 테두리
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill;

    /// Thumb 동그라미
    final Paint paint = Paint()
      ..color = sliderTheme!.thumbColor!
      ..style = PaintingStyle.fill;

    /// valur text.
    final TextSpan span = TextSpan(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ),
      text: '${currentValue.round()}',
    );

    final TextPainter textPainter = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    canvas.drawCircle(center, thumbRadius + 2, borderPaint);
    canvas.drawCircle(center, thumbRadius, paint);

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(center.dx - (textPainter.width / 2),
          center.dy - (textPainter.height / 2)),
    );
  }
}
