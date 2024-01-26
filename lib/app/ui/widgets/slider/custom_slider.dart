import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';

import 'border_thumb_shape.dart';
import 'custom_slider_tick_mark_shape.dart';

/// 슬라이더.
class CustomSlider extends StatelessWidget {
  final double value;

  final Color color;

  final Function(double value) onChanged;

  final double minValue;

  final double maxValue;

  final int divisions;

  const CustomSlider({
    super.key,
    required this.value,
    required this.color,
    this.minValue = 1,
    this.maxValue = 7,
    this.divisions = 6,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: SliderTheme(
          data: SliderThemeData(
            trackHeight: 10,
            activeTrackColor: color,
            inactiveTrackColor: ColorRes.white,
            thumbColor: color,
            thumbShape: BorderThumbShape(),
            showValueIndicator: ShowValueIndicator.always,
            overlayShape: SliderComponentShape.noOverlay,
            overlayColor: Colors.blue.withOpacity(0.3),
            tickMarkShape: CustomSliderTickMarkShape(),
          ),
          child: Slider(
            value: value,
            min: minValue,
            max: maxValue,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      );
}
