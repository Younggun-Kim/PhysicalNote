import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/history/history.dart';
import 'package:physical_note/app/ui/page/history/type/history_filter_type.dart';
import 'package:physical_note/app/ui/page/history/type/history_page_key_type.dart';

void main() {
  late HistoryController controller;
  setUp(() {
    controller = Get.put(HistoryController());
  });

  pumpWidget(WidgetTester tester) =>
      tester.pumpWidget(const MaterialApp(home: HistoryPage()));

  group('Header 테스트', () {
    testWidgets('타이틀 테스트', (WidgetTester tester) async {
      await pumpWidget(tester);

      expect(find.text(StringRes.myHistory.tr), findsOneWidget);
    });

    testWidgets('필터 초기 상태 테스트', (WidgetTester tester) async {
      await pumpWidget(tester);

      final filterButton = find.byKey(const Key('HistoryHeaderFilterButton'));
      expect(filterButton, findsOneWidget);
      expect(
        find.descendant(
            of: filterButton,
            matching: find.text(StringRes.historyFilterAll.tr)),
        findsOneWidget,
      );
    });

    testWidgets('필터 변경 후 랜딩 테스트', (WidgetTester tester) async {
      await pumpWidget(tester);

      controller.setFilter(HistoryFilterType.oldest);

      final filterButton = find.byKey(HistoryPageKeyType.filterButton.key);
      expect(filterButton, findsOneWidget);
      expect(
        find.descendant(
            of: filterButton,
            matching: find.text(StringRes.historyFilterAll.tr)),
        findsOneWidget,
      );

      await tester.pump();

      expect(
        find.descendant(
            of: filterButton,
            matching: find.text(StringRes.historyFilterOldest.tr)),
        findsOneWidget,
      );
    });

    testWidgets('필터 클릭 테스트', (WidgetTester tester) async {
      // 클릭하면 필터가 나와야하고
      // 그럴려면 컨트롤러가 변경되어야 하고
      // 이걸 몯라로 해볼 예정이긴 함
    });
  });

  group('탭 테스트', () {
    testWidgets('탭 초기 상태 테스트', (WidgetTester tester) async {
      await pumpWidget(tester);

      // TabBar 확인
      expect(find.byType(TabBar), findsOneWidget);
      final TabBar tabBar = tester.widget<TabBar>(find.byType(TabBar));

      // Tab 3개 확이
      expect(find.byType(Tab), findsNWidgets(3));

      // Tab 내 텍스트 확인
      final tabTexts = [
        StringRes.wellness.tr,
        StringRes.workoutIntensity.tr,
        StringRes.injuryManagement.tr,
      ];
      for (final text in tabTexts) {
        expect(
          find.descendant(
            of: find.byType(Tab),
            matching: find.text(text),
          ),
          findsOneWidget,
          reason: 'Tab with text "$text" not found',
        );
      }

      // Tab에서 첫번째가 선택되어 있는지 확인
      expect(tabBar.controller?.index, 0);
    });

    testWidgets('탭 운동강도로 변경', (WidgetTester tester) async {
      await pumpWidget(tester);

      final tabController = controller.tabController;
      expect(tabController, isNotNull);
      expect(tabController.index, 0);
      expect(tabController.previousIndex, 0);

      final intensityTab = find.descendant(
        of: find.byType(Tab),
        matching: find.text(
          StringRes.workoutIntensity.tr,
        ),
      );
      expect(intensityTab, findsOneWidget);

      /// 운동 강도 탭
      await tester.tap(intensityTab);
      await tester.pump();
      expect(tabController.indexIsChanging, true);

      // 애니메이션 끝나기 기다리기
      await tester.pump(const Duration(seconds: 1));

      // 변경 확인
      expect(tabController.index, 1);
      expect(tabController.previousIndex, 0);
      expect(tabController.indexIsChanging, false);
    });
  });
}
