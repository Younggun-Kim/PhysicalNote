import 'dart:math';

import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class LevelProgressBar extends StatelessWidget {
  final double size;

  final String title;

  final double value;

  final Color primaryColor;

  const LevelProgressBar({
    super.key,
    required this.size,
    required this.title,
    required this.value,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: SleekCircularSlider(
              appearance: CircularSliderAppearance(
                animationEnabled: false,
                angleRange: 360,
                startAngle: 270,
                customWidths: CustomSliderWidths(
                  trackWidth: 10,
                  progressBarWidth: 10,
                  handlerSize: 0,
                  shadowWidth: 0,
                ),
                customColors: CustomSliderColors(
                  trackColor: ColorRes.grayEdeded,
                  progressBarColor: primaryColor,
                  hideShadow: true,
                ),
                infoProperties: InfoProperties(
                  modifier: (double value) {
                    return "${value.toInt()}";
                  },
                  mainLabelStyle: const TextStyle(
                    fontSize: 14,
                    color: ColorRes.fontBlack,
                  ),
                ),
              ),
              min: 0,
              max: 10,
              initialValue: min(value, 10),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: ColorRes.fontBlack
            ),
          ),
        ],
      );
}
