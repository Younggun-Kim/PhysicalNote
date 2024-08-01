import 'package:physical_note/app/utils/extensions/date_extensions.dart';

/// 운동강도 목록 Item UiState
// TODO: 평균 스포츠/피지컬 레벨 API 수정 필요
class HistoryIntensityItemUiState {
  final String id;
  final int? sportLevel;
  final String? sportTime;
  final int? physicalLevel;
  final String? physicalTime;
  final DateTime recordDate;
  String? lastWeekAverageTime;
  String? thisWeekAverageTime;
  String? sportLevelAverage;
  String? physicalLevelAverage;

  /// 포맷 날짜
  String get formattedRecordDate => recordDate.toFormattedString('yyyy-MM-dd');

  HistoryIntensityItemUiState({
    required this.id,
    required this.sportLevel,
    required this.sportTime,
    required this.physicalLevel,
    required this.physicalTime,
    required this.recordDate,
    this.lastWeekAverageTime,
    this.thisWeekAverageTime,
    this.sportLevelAverage,
    this.physicalLevelAverage,
  });
}
