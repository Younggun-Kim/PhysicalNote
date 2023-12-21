import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/data/data_controller.dart';
import 'package:physical_note/app/ui/page/data/data_menu_type.dart';
import 'package:physical_note/app/ui/page/data/injury/injury_page.dart';
import 'package:physical_note/app/ui/page/data/wellness/wellness_page.dart';
import 'package:physical_note/app/ui/widgets/custom_calendar/expansion_calendar.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'intensity/intensity_page.dart';

class DataPage extends GetView<DataController> {
  const DataPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: NestedScrollView(
          controller: controller.scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 20),
                    Obx(
                      () => ExpansionCalendar(
                        uiState: controller.calendarUiState.value,
                        onPressedYear: controller.onPressedYear,
                        onToggleExpanded: controller.onToggleCalendarExpanded,
                        onPressedPrev: controller.onPressedCalendarPrev,
                        onPressedNext: controller.onPressedCalendarNext,
                        onChangedDate: controller.onChangedDate,
                        onPageChanged: controller.onPageChanged,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => _DataMenu(
                        currentMenu: controller.menu.value,
                        onTap: controller.onTapMenu,
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: Obx(
            () => PageView(
              controller: controller.pageController.value,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SizedBox.expand(
                  child: Obx(
                    () => WellnessPage(
                      hooperIndexUiState:
                          controller.wellnessHooperIndexUiState.value,
                      onChangeHooperIndex: controller.onChangeHooperIndex,
                      table: controller.wellnessUrineTable.value,
                      onChangedUrine: controller.onChangedUrine,
                      weightController:
                          controller.wellnessUrineWeight.controller,
                      bmiController: controller.wellnessUrineBmi.controller,
                      onPressedWellnessSave: () {
                        controller.onPressedWellnessSave.emit();
                      },
                      isWellnessLoaded: controller.wellnessId.value != null,
                    ),
                  ),
                ),
                SizedBox.expand(child: IntensityPage()),
                SizedBox.expand(child: InjuryPage()),
              ],
            ),
          ),
        ),
      );
}

class _DataMenu extends StatelessWidget {
  final DataMenuType currentMenu;

  final Function(DataMenuType type) onTap;

  const _DataMenu({required this.currentMenu, required this.onTap});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _DataMenuItem(
                    type: DataMenuType.wellness,
                    isSelected: currentMenu == DataMenuType.wellness,
                    onTap: onTap,
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: _DataMenuItem(
                    type: DataMenuType.intensity,
                    isSelected: currentMenu == DataMenuType.intensity,
                    onTap: onTap,
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: _DataMenuItem(
                    type: DataMenuType.injury,
                    isSelected: currentMenu == DataMenuType.injury,
                    onTap: onTap,
                  ),
                ),
                const SizedBox(width: 5),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: ColorRes.disable,
            )
          ],
        ),
      );
}

class _DataMenuItem extends StatelessWidget {
  final DataMenuType type;

  final bool isSelected;

  final Function(DataMenuType type) onTap;

  const _DataMenuItem({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWellOver(
        onTap: () {
          onTap(type);
        },
        child: Column(
          children: [
            Text(
              type.toString(),
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? ColorRes.fontBlack : ColorRes.fontDisable,
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 3,
              color: isSelected ? ColorRes.borderDeselect : Colors.transparent,
            )
          ],
        ),
      );
}
