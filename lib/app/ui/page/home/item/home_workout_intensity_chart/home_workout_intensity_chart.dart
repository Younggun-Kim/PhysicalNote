import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';

import 'home_workout_intensity_chart_ui_state.dart';

class HomeWorkoutIntensityChart extends StatelessWidget {
  final HomeWorkoutIntensityChartUiState uiState;

  const HomeWorkoutIntensityChart({
    super.key,
    required this.uiState,
  });

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            // pieTouchData: () {},
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 2.0,
            centerSpaceRadius: 18,
            sections: showingSections(uiState.value),
          ),
        ),
      );

  List<PieChartSectionData> showingSections(double value) {
    const fontSize = 10.0;
    const radius = 18.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

    return [
      PieChartSectionData(
        color: Colors.blue,
        value: value,
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: ColorRes.fontBlack,
          shadows: shadows,
        ),
      ),
      if (uiState.remainValue > 0)
        PieChartSectionData(
          color: Colors.grey,
          value: uiState.remainValue,
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: ColorRes.fontBlack,
            shadows: shadows,
          ),
        ),
    ];
  }
}
