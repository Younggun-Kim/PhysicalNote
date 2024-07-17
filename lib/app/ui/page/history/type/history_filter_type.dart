import 'package:get/get.dart';
import 'package:physical_note/app/resources/strings/translations.dart';

/// 이력 공통 필터 타입
enum HistoryFilterType {
  all,
  week,
  month,
  latest,
  oldest,
  progressInjury,
  healedInjury;

  @override
  String toString() {
    switch (this) {
      case HistoryFilterType.all:
        return StringRes.historyFilterAll.tr;
      case HistoryFilterType.week:
        return StringRes.historyFilterWeek.tr;
      case HistoryFilterType.month:
        return StringRes.historyFilterMonth.tr;
      case HistoryFilterType.latest:
        return StringRes.historyFilterLatest.tr;
      case HistoryFilterType.oldest:
        return StringRes.historyFilterOldest.tr;
      case HistoryFilterType.progressInjury:
        return StringRes.historyFilterProgressInjury.tr;
      case HistoryFilterType.healedInjury:
        return StringRes.historyFilterHealedInjury.tr;
    }
  }

  /// 공통 필터 목록
  static List<HistoryFilterType> commonList = [
    HistoryFilterType.all,
    HistoryFilterType.week,
    HistoryFilterType.month,
    HistoryFilterType.latest,
    HistoryFilterType.oldest,
  ];

  /// 부상 필터 목록
  static List<HistoryFilterType> injuryList = [
    HistoryFilterType.all,
    HistoryFilterType.latest,
    HistoryFilterType.oldest,
    HistoryFilterType.progressInjury,
    HistoryFilterType.healedInjury,
  ];
}
