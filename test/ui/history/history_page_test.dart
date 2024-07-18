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
    Get.testMode = true;
    controller = Get.put(HistoryController());
  });

  pumpWidget(WidgetTester tester) =>
      tester.pumpWidget(const GetMaterialApp(home: HistoryPage()));

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
  });

  group('탭 테스트', () {
    testWidgets('탭 초기 상태 테스트', (WidgetTester tester) async {
      await pumpWidget(tester);

      // TabBar 확인
      expect(find.byType(TabBar), findsOneWidget);
      final TabBar tabBar = tester.widget<TabBar>(find.byType(TabBar));

      // Tab 3개 확인
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

  group('필터 드롭다운 모달 테스트', () {
    Future<Finder> getDropdownDialog(WidgetTester tester) async {
      final filterButton = find.byKey(HistoryPageKeyType.filterButton.key);
      expect(filterButton, findsOneWidget);

      final filterInkWell = find.descendant(
        of: filterButton,
        matching: find.byType(InkWell),
      );

      expect(filterInkWell, findsOneWidget);

      await tester.tap(filterInkWell);
      await tester.pumpAndSettle();

      return find.byKey(HistoryPageKeyType.dropDownDialog.key);
    }

    testWidgets('필터 클릭 시 드롭다운 모달 Visible 테스트', (WidgetTester tester) async {
      await pumpWidget(tester);

      final dialog = await getDropdownDialog(tester);
      expect(dialog, findsOneWidget);

      final filterList =
          controller.filterList.map((e) => e.toString()).toList();

      for (final text in filterList) {
        expect(
          find.descendant(
            of: dialog,
            matching: find.text(text),
          ),
          findsOneWidget,
        );
      }
    });

    testWidgets('열린 드롭다운 다이얼로그 닫기 테스트', (WidgetTester tester) async {
      await pumpWidget(tester);
      final dialog = await getDropdownDialog(tester);
      expect(dialog, findsOneWidget);

      final TestGesture gesture =
          await tester.startGesture(tester.getRect(dialog).center);
      await tester.pumpAndSettle();
      await gesture.up();
      await tester.pumpAndSettle();

      expect(dialog, findsNothing);
    });

    testWidgets('드롭다운 필터 선택 후 필터 바꼈는지 검사', (WidgetTester tester) async {
      await pumpWidget(tester);

      // 1. 드롭다운 다이얼로그 표시 확인
      final dialog = await getDropdownDialog(tester);
      expect(dialog, findsOneWidget);

      // 2. 드롭다운에 올바른 필터 옵션 포함 확인
      final filterList =
          controller.filterList.map((e) => e.toString()).toList();
      final lastFilterOption = find.descendant(
        of: dialog,
        matching: find.text(filterList.last),
      );
      expect(lastFilterOption, findsOneWidget);

      // 3. 필터 선택 및 다이얼로그 닫힘 확인
      await tester.tap(lastFilterOption);
      await tester.pumpAndSettle();
      expect(dialog, findsNothing);

      // 4. 선택된 필터가 버튼에 반영되었는지 확인
      final filterButton = find.byKey(HistoryPageKeyType.filterButton.key);
      expect(filterButton, findsOneWidget);
      expect(
        find.descendant(of: filterButton, matching: find.text(filterList.last)),
        findsOneWidget,
      );
    });

    testWidgets('부산 탭일 때 필터내용이 맞게 나오는지 테스트', (WidgetTester tester) async {
      await pumpWidget(tester);

      // 부상관리 탭 클릭.
      final injuryTab = find.descendant(
        of: find.byType(Tab),
        matching: find.text(
          StringRes.injuryManagement.tr,
        ),
      );
      expect(injuryTab, findsOneWidget);
      await tester.tap(injuryTab);
      await tester.pumpAndSettle();
      expect(controller.tabController.index, 2);

      // 2. 드롭다운 다이얼로그 표시 확인
      final dialog = await getDropdownDialog(tester);
      expect(dialog, findsOneWidget);

      // 3. 드롭다운 메뉴 확인
      final menuList = HistoryFilterType.injuryList.map((e) => e.toString());
      for (final menu in menuList) {
        expect(
          find.descendant(
            of: dialog,
            matching: find.text(menu),
          ),
          findsOneWidget,
        );
      }
    });
  });
}
