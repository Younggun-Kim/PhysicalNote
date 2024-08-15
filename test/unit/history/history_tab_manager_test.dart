import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:physical_note/app/ui/page/history/history_tab_manager.dart';

@GenerateMocks([TabController])
import 'history_tab_manager_test.mocks.dart';

void main() {
  late MockTabController mockTabController;
  late HistoryTabManager tabManager;

  setUp(() {
    mockTabController = MockTabController();
    tabManager = HistoryTabManager(mockTabController);
  });

  group('HistoryTabManager 클래스 테스트', () {

    test('resetTab', () {
      tabManager.reset();
      verify(mockTabController.index = 0).called(1);
    });

    test('changeTab with animation', () {
      tabManager.changeTab(index: 2, animate: true);

      verify(mockTabController.animateTo(2)).called(1);

      /**
       * expect(mockTabController.index, 2); => Error
       * index 속성은 일반적으로 animateTo 메서드 호출의 직접적인 결과로 변경되지 않기 때문입니다.
       * 애니메이션이 완료된 후에 변경될 수 있습니다.
       */
    });

    test('changeTab without animate', () {
      tabManager.changeTab(index: 2, animate: false);

      verify(mockTabController.index = 2).called(1);

      // expect(mockTabController.index, 2);
      /**
       * tabController를 테스트하면 안되는 점
       * 1. 캡슐화 위반
       * - tabController는 manager의 내부 구현사항이다.
       * - 직접적인 테스트는 캡슐화를 깨뜨릴 수 있다
       * 2. 취약한 테스트
       * - 내부 구현에 의존하는 테스트는 내부 구현이 변경될 때마다 깨질 위험이 있다
       * 3. 책임 분리
       * - manager에서 tabController를 사용하지만, 내부 상태를 관리하는 것은
       * - tabController의 역할이다.
       */
    });
  });
}
