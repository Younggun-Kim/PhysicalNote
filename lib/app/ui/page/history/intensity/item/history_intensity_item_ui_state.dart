import 'package:physical_note/app/utils/extensions/date_extensions.dart';

/// 운동강도 목록 Item UiState
class HistoryIntensityItemUiState {
  final String id;
  final int? sportLevel;
  final String? sportTime;
  final int? physicalLevel;
  final String? physicalTime;
  final DateTime recordDate;
  final bool onlyAverage;
  String? lastWeekAverageTime;
  String? thisWeekAverageTime;
  double? sportLevelAverage;
  double? physicalLevelAverage;

  /// 포맷 날짜
  String get formattedRecordDate => recordDate.toFormattedString('yyyy-MM-dd');

  HistoryIntensityItemUiState({
    required this.id,
    required this.sportLevel,
    required this.sportTime,
    required this.physicalLevel,
    required this.physicalTime,
    required this.recordDate,
    this.onlyAverage = false,
    this.lastWeekAverageTime,
    this.thisWeekAverageTime,
    this.sportLevelAverage,
    this.physicalLevelAverage,
  });
}
