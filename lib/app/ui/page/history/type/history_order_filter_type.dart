import 'package:get/get.dart';
import 'package:physical_note/app/resources/strings/translations.dart';

/// 정렬 필터 타입
enum HistoryOrderFilterType {
  asc,
  desc;

  @override
  String toString() {
    switch (this) {
      case HistoryOrderFilterType.asc:
        return StringRes.historyFilterAsc.tr;
      case HistoryOrderFilterType.desc:
        return StringRes.historyFilterDesc.tr;
      default:
        throw Exception('unexpected HistoryOrderFilterType: $this');
    }
  }
}
