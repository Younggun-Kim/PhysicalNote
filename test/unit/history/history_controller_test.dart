import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/history/history.dart';
import 'package:physical_note/app/ui/page/history/type/history_filter_type.dart';

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

    test('필터 목록 초기 상태 테스트', () {
      final initializedFilterList = controller.filterList.toList();
      expect(initializedFilterList, HistoryFilterType.commonList);
    });

    test('탭 변경시 필터 목록 변경 테스트', () {
      final tabController = controller.tabController;
      expect(tabController.index, 0);
      expect(controller.filterList, HistoryFilterType.commonList);

      controller.changeTab(1);
      expect(tabController.index, 1);
      expect(controller.filterList, HistoryFilterType.commonList);

      controller.changeTab(2);
      expect(tabController.index, 2);
      expect(controller.filterList, HistoryFilterType.injuryList);
    });
  });

  group('필터 테스트', () {
    test('필터 초기 상태 테스트', () {
      expect(controller.filter.value, HistoryFilterType.all);
      expect(controller.isVisibleFilterModal.value, false);
    });

    test('필터 변경 테스트', (){
      // 각 탭마다 맞는 필터가 있는가 검사
      // 필터가 잘 변경되었는가 테스트
    });
  });
}
