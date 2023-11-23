import 'dart:math';
import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/home/home_workout_intensity_chart/home_workout_intensity_chart_ui_state.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';


/// 홈 운동강도 프로그레스바.
class HomeWorkoutIntensityProgressBar extends StatelessWidget {
  final HomeWorkoutIntensityChartUiState uiState;

  const HomeWorkoutIntensityProgressBar({
    super.key,
    required this.uiState,
  });

  @override
  Widget build(BuildContext context) => SleekCircularSlider(
        appearance: CircularSliderAppearance(
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
            progressBarColor: ColorRes.risk0,
            hideShadow: true,
          ),
          infoProperties: InfoProperties(
            modifier: (double value) {
              return "$value";
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
      );
}
