import 'package:physical_note/app/ui/page/history/type/history_date_filter_type.dart';
import 'package:physical_note/app/ui/page/history/type/history_order_filter_type.dart';

/// 이력 필터 다이얼로그 Args
class HistoryFilterDialogArgs {
  final HistoryDateFilterType dateType;

  final HistoryOrderFilterType orderType;

  /// 부상 완치여부 - 부상 관리에서만Ï 사용
  final bool? isRecovery;

  final bool isVisibleRecovery;

  HistoryFilterDialogArgs({
    required this.dateType,
    required this.orderType,
    required this.isVisibleRecovery,
    required this.isRecovery,
  });
}
