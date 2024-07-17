import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/history/history.dart';

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

  group('이력 컨트롤러 테스트', () {
    test('탭 초기 상태 테스트', () {
      // 탭이 3개인지 검사
      expect(controller.tabController.length, 3);

      expect(controller.tabController.offset, 0);

      expect(controller.tabController.index, 0);
    });

    test('탭 이동 테스트', () {
      controller.tabController.index = 1;
      expect(controller.tabController.index, 1);

      controller.tabController.animateTo(2);
      expect(controller.tabController.index, 2);
    });
  });
}
