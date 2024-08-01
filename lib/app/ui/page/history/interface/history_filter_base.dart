import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/history/type/history_order_filter_type.dart';

import '../type/history_date_filter_type.dart';

abstract class HistoryFilterBase {
  final Rx<HistoryDateFilterType> dateFilter;
  final Rx<HistoryOrderFilterType> orderFilter;

  HistoryFilterBase({
    required this.dateFilter,
    required this.orderFilter,
  });
}
