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
import 'package:physical_note/app/utils/utils.dart';
import 'package:table_calendar/table_calendar.dart';

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
                          focusDate: controller.focusDate.value,
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
  final DateTime currentDate;
  final DateTime focusDate;

  final Function(DateTime newDate, DateTime focusDate) onChangedDate;

  const _Calendar({
    required this.currentDate,
    required this.onChangedDate,
    required this.focusDate,
  });

  /// 달력 로케일.
  String _locale() {
    final deviceLocale = Get.deviceLocale;
    if (deviceLocale == null) {
      return "ko_KR";
    }

    return "${deviceLocale.languageCode}_${deviceLocale.countryCode}";
  }

  @override
  Widget build(BuildContext context) => TableCalendar(
        headerVisible: false,
        firstDay: DateTime.utc(2021, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        // 달력 스크롤 잡아 주는 역할
        focusedDay: focusDate,
        currentDay: currentDate,
        locale: _locale(),
        daysOfWeekHeight: 24,
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorRes.gray5,
          ),
          weekendStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorRes.gray5,
          ),
        ),
        calendarStyle: const CalendarStyle(
          todayTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorRes.gray10,
          ),
          todayDecoration: BoxDecoration(),
          selectedTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorRes.white,
          ),
          selectedDecoration: BoxDecoration(
            color: ColorRes.primary,
            shape: BoxShape.circle,
          ),
          outsideTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorRes.gray5,
          ),
        ),
        onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
          logger.w(selectedDay);
          onChangedDate(selectedDay, focusedDay);
        },
        selectedDayPredicate: (DateTime day) {
          /// 날짜 선택 처리.
          return currentDate == day;
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
