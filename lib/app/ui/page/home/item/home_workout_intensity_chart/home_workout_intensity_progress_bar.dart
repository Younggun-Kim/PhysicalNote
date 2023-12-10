import 'dart:math';
import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'home_workout_intensity_chart_ui_state.dart';

/// 홈 운동강도 프로그레스바.
class HomeWorkoutIntensityProgressBar extends StatelessWidget {
  final HomeWorkoutIntensityChartUiState uiState;

  const HomeWorkoutIntensityProgressBar({
    super.key,
    required this.uiState,
  });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      AspectRatio(
        aspectRatio: 1 / 1,
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
              trackColor: ColorRes.disable,
              progressBarColor: Colors.red,
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
          initialValue: min(uiState.value, 10),
        ),
      ),
      const SizedBox(height: 5),
      Text(
        uiState.name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    ],
  );
}
