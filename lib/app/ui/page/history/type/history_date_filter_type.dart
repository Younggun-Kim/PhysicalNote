import 'package:get/get.dart';
import 'package:physical_note/app/resources/strings/translations.dart';

/// 이력 공통 필터 타입
enum HistoryDateFilterType {
  all,
  week,
  month;

  @override
  String toString() {
    switch (this) {
      case HistoryDateFilterType.all:
        return StringRes.historyFilterAll.tr;
      case HistoryDateFilterType.week:
        return StringRes.historyFilterWeek.tr;
      case HistoryDateFilterType.month:
        return StringRes.historyFilterMonth.tr;
    }
  }
}
