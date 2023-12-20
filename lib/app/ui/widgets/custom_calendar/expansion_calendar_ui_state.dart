/// 확장 달력 Ui State.
class ExpansionCalendarUiState {
  /// 확장 여부.
  bool isExpanded;

  /// 현재 날짜.
  DateTime currentDate;

  /// 현재 달력 노출되는 날짜.
  DateTime focusedDate;

  ExpansionCalendarUiState({
    required this.isExpanded,
    required this.currentDate,
    required this.focusedDate,
  });
}
