import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/data/data_controller.dart';
import 'package:physical_note/app/ui/page/data/data_menu_type.dart';
import 'package:physical_note/app/ui/page/data/injury/injury_page.dart';
import 'package:physical_note/app/ui/page/data/intensity/intensity_page.dart';
import 'package:physical_note/app/ui/page/data/wellness/wellness_page.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';

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
                    const SizedBox(height: 40),
                    Obx(() => _Calendar(
                          currentDate: controller.date.value,
                          onChangedDate: controller.onChangedDate,
                        )),
                    const SizedBox(height: 40),
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
                SizedBox.expand(child: WellnessPage()),
                SizedBox.expand(child: IntensityPage()),
                SizedBox.expand(child: InjuryPage()),
              ],
            ),
          ),
        ),
      );
}

/// 달력.
class _Calendar extends StatelessWidget {
  final DateTime? currentDate;

  final Function(DateTime? newDate) onChangedDate;

  const _Calendar({
    required this.currentDate,
    required this.onChangedDate,
  });

  // 날짜 텍스트 스타일.
  TextStyle _getDayTextStyle({required bool isSelected}) => TextStyle(
        fontSize: 14,
        color: isSelected ? ColorRes.white : ColorRes.fontBlack,
        fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
      );

  @override
  Widget build(BuildContext context) => CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          todayTextStyle: _getDayTextStyle(isSelected: false),
          dayTextStyle: _getDayTextStyle(isSelected: false),
          selectedDayTextStyle: _getDayTextStyle(isSelected: true),
          selectedDayHighlightColor: ColorRes.primary,
          centerAlignModePicker: false,
        ),
        value: [currentDate],
        onValueChanged: (newDates) {
          onChangedDate(newDates.first);
        },
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
