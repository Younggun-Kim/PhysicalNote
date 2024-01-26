/// 홈 - 운동강도 UiState.
class HomeWorkoutIntensityChartUiState {
  final String name;

  final double value;

  late final remainValue = 10.0 - value;

  HomeWorkoutIntensityChartUiState({
    required this.name,
    required this.value,
  });
}
