/// 데이터 - 웰리니스 - 소변검사 UiState.
class DataWellnessUrineUiState {
  /// 소변검사표.
  double table;

  /// 몸무게.
  double? weight;

  /// 체지방률.
  double? bmi;

  DataWellnessUrineUiState({
    required this.table,
    this.weight,
    this.bmi,
  });
}
