import 'package:physical_note/app/utils/extensions/date_extensions.dart';
import 'package:physical_note/app/utils/localization/localization_utils.dart';

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

  String get displayRecordDate => LocalizationUtil.getDateStr(
        date: formattedRecordDate,
        koFormat: "yy.MM.dd(EEE)",
        enFormat: "MMMM dd, yy (E)",
      );

  String get displaySportTime => LocalizationUtil.getDateStr(
    date: sportTime ?? '',
    koFormat: "HH:mm",
    enFormat: "HH:mm",
    originFormat: "HH:mm:ss",
  );

  String get displayPhysicalTime => LocalizationUtil.getDateStr(
    date: physicalTime ?? '',
    koFormat: "HH:mm",
    enFormat: "HH:mm",
    originFormat: "HH:mm:ss",
  );

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
