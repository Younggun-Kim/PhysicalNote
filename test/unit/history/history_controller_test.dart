import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/history/history.dart';
import 'package:physical_note/app/ui/page/history/type/history_date_filter_type.dart';

void main() {
  late HistoryController controller;

  setUp(() {
    // 의존성 주입
    HistoryBindings().dependencies();
    controller = Get.find<HistoryController>();
  });

  tearDown(() {
    Get.delete<HistoryController>();
  });

  group('필터 테스트', () {
    test('필터 초기 상태 테스트', () {
      expect(controller.dateFilter.value, HistoryDateFilterType.all);
    });
  });
}
