import 'package:physical_note/app/utils/extensions/date_extensions.dart';

/// 운동강도 목록 Item UiState
class HistoryIntensityItemUiState {
  final int id;
  final int sportLevel;
  final String sportTime;
  final int physicalLevel;
  final String physicalTime;
  final DateTime recordDate;

  /// 포맷 날짜
  String get formattedRecordDate => recordDate.toFormattedString('yyyy-MM-dd');

  HistoryIntensityItemUiState({
    required this.id,
    required this.sportLevel,
    required this.sportTime,
    required this.physicalLevel,
    required this.physicalTime,
    required this.recordDate,
  });
}
