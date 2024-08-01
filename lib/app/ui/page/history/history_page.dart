import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/history/history_controller.dart';
import 'package:physical_note/app/ui/page/history/injury/history_injury_page.dart';
import 'package:physical_note/app/ui/page/history/intensity/history_intensity_page.dart';
import 'package:physical_note/app/ui/page/history/wellness/history_wellness_page.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

import 'type/history_page_key_type.dart';

/// 이력 홈 화면
class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        floatingActionButton: _FloatingButton(),
        child: Column(
          children: [
            const SizedBox(height: 40),
            _Header(),
            const SizedBox(height: 50),
            TabBar(
              controller: controller.tabController,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              labelColor: ColorRes.fontBlack,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.fontDisable),
              overlayColor:
                  WidgetStateProperty.all(ColorRes.gray9f9f9f.withAlpha(30)),
              indicatorColor: ColorRes.gray9f9f9f,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: ColorRes.disable,
              dividerHeight: 0.5,
              onTap: (int index) {
                controller.changeTab(index);
              },
              tabs: [
                Tab(child: Text(StringRes.wellness.tr)),
                Tab(child: Text(StringRes.workoutIntensity.tr)),
                Tab(child: Text(StringRes.injuryManagement.tr)),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.tabController,
                children: [
                  HistoryWellnessPage(
                    key: HistoryPageKeyType.wellness.key,
                  ),
                  HistoryIntensityPage(
                    key: HistoryPageKeyType.intensity.key,
                  ),
                  HistoryInjuryPage(
                    key: HistoryPageKeyType.injury.key,
                  ),
                ],
              ),
            )
          ],
        ),
      );
}

/// 헤더 영역
class _Header extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                StringRes.myHistory.tr,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1,
                ),
              ),
            ),
            Obx(
              () => _Filter(
                key: HistoryPageKeyType.filterButton.key,
                text: controller.dateFilter.toString(),
                onPressed: () {
                  controller.showDateFilterDialog();
                },
              ),
            ),
            const SizedBox(width: 10),
            Obx(
              () => _Filter(
                text: controller.orderFilter.toString(),
                onPressed: () {
                  controller.showOrderFilterDialog();
                },
              ),
            ),
          ],
        ),
      );
}

/// 필터
class _Filter extends StatelessWidget {
  final String text;

  final VoidCallback onPressed;

  const _Filter({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) => InkWellOver(
        key: key,
        onTap: onPressed,
        child: Row(
          children: [
            Text(
              text,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.fontBlack),
            ),
            const SizedBox(width: 14),
            SvgPicture.asset(Assets.chevronDownBlack),
          ],
        ),
      );
}

class _FloatingButton extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) => InkWellOver(
        onTap: controller.onPressedFloatingButton,
        borderRadius: BorderRadius.circular(50),
        child: SvgPicture.asset(Assets.wellnessFloatingButton),
      );
}
