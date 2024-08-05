import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/history/type/history_order_filter_type.dart';

import '../type/history_date_filter_type.dart';

abstract class HistoryFilterBase {
  final Rx<HistoryDateFilterType> dateFilter;
  final Rx<HistoryOrderFilterType> orderFilter;

  /// 부상관리에서만 사용
  final Rx<bool?> isRecovery;

  HistoryFilterBase({
    required this.dateFilter,
    required this.orderFilter,
    required this.isRecovery,
  });
}
