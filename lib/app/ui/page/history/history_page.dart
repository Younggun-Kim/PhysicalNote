import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/colors/color_res.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/history/history_controller.dart';
import 'package:physical_note/app/ui/page/history/type/history_tab_type.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';

/// 이력 홈 화면
class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: Column(
          children: [
            TabBar(
              controller: controller.tabController,
              labelColor: ColorRes.fontBlack,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                color: ColorRes.fontDisable
              ),
              overlayColor: WidgetStateProperty.all(ColorRes.gray9f9f9f.withAlpha(30)),
              indicatorColor: ColorRes.gray9f9f9f,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: ColorRes.disable,
              dividerHeight: 0.5,
              tabs: [
                Tab(child: Text(StringRes.wellness.tr)),
                Tab(child: Text(StringRes.workoutIntensity.tr)),
                Tab(child: Text(StringRes.injuryManagement.tr)),
              ],
            ),
            Expanded(
                child: TabBarView(
              controller: controller.tabController,
              children: [
                Text('1'),
                Text('2'),
                Text('3'),
              ],
            ))
          ],
        ),
      );
}
