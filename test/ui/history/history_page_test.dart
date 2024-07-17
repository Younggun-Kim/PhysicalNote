import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/history/history.dart';

void main() {
  late HistoryController controller;
  setUp(() {
    controller = Get.put(HistoryController());
  });

  pumpWidget(WidgetTester tester) =>
      tester.pumpWidget(const MaterialApp(home: HistoryPage()));

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
}
