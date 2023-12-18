import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/data/data_controller.dart';
import 'package:physical_note/app/ui/page/data/data_menu_type.dart';
import 'package:physical_note/app/ui/page/data/injury/injury_page.dart';
import 'package:physical_note/app/ui/widgets/buttons/outline_round_button.dart';
import 'package:physical_note/app/ui/page/data/wellness/wellness_page.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:table_calendar/table_calendar.dart';

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
                    const SizedBox(height: 40),
                    Obx(
                      () => _Calendar(
                        isOpen: controller.isCalendarOpen.value,
                        currentDate: controller.date.value,
                        focusDate: controller.focusedDate.value,
                        onChangedDate: controller.onChangedDate,
                        onPageChanged: controller.onPageChanged,
                        onToggleOpen: controller.onToggleOpen,
                        onPressedPrev: controller.onPressedCalendarPrev,
                        onPressedNext: controller.onPressedCalendarNext,
                      ),
                    ),
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
              children: const [
                SizedBox.expand(child: WellnessPage()),
                SizedBox.expand(child: IntensityPage()),
                SizedBox.expand(child: InjuryPage()),
              ],
            ),
          ),
        ),
      );
}

class _CalendarHeader extends StatelessWidget {
  final bool isExpanded;
  final DateTime focusedDate;
  final VoidCallback onToggleOpen;
  final VoidCallback onPressedPrev;
  final VoidCallback onPressedNext;

  const _CalendarHeader({
    required this.isExpanded,
    required this.focusedDate,
    required this.onToggleOpen,
    required this.onPressedPrev,
    required this.onPressedNext,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: isExpanded ? closeWidget() : openWidget(),
      );

  Widget closeWidget() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWellOver(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  focusedDate.year.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: ColorRes.fontBlack,
                  ),
                ),
                const Icon(
                  Icons.expand_more,
                  color: ColorRes.primary,
                ),
              ],
            ),
          ),
          const Spacer(),
          InkWellOver(
            borderRadius: BorderRadius.circular(15),
            onTap: onPressedPrev,
            child: const Icon(
              Icons.chevron_left,
              size: 30,
              color: ColorRes.primary,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            focusedDate.toFormattedString("MM"),
            style: const TextStyle(
              fontSize: 24,
              color: ColorRes.fontBlack,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 10),
          InkWellOver(
            borderRadius: BorderRadius.circular(15),
            onTap: onPressedNext,
            child: const Icon(
              Icons.chevron_right,
              size: 30,
              color: ColorRes.primary,
            ),
          ),
          const Spacer(),
          OutlineRoundButton(
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            hint: "",
            text: StringRes.close.tr,
            onPressed: () {
              onToggleOpen();
            },
          )
        ],
      );

  Widget openWidget() => Stack(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              focusedDate.toFormattedString("yy년 M월 d일"),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                color: ColorRes.fontBlack,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: OutlineRoundButton(
                  height: 28,
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  hint: "",
                  text: StringRes.open.tr,
                  onPressed: () {
                    onToggleOpen();
                  },
                ),
              ))
        ],
      );
}

/// 달력.
class _Calendar extends StatelessWidget {
  final bool isOpen;
  final DateTime currentDate;
  final DateTime focusDate;
  final Function(DateTime newDate, DateTime focusDate) onChangedDate;
  final Function(DateTime focusDate) onPageChanged;
  final VoidCallback onToggleOpen;
  final VoidCallback onPressedPrev;
  final VoidCallback onPressedNext;

  const _Calendar({
    required this.isOpen,
    required this.currentDate,
    required this.onChangedDate,
    required this.focusDate,
    required this.onPageChanged,
    required this.onToggleOpen,
    required this.onPressedPrev,
    required this.onPressedNext,
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
  Widget build(BuildContext context) => ExpansionWidget(
        initiallyExpanded: isOpen,
        onRestoreState: () => isOpen,
        titleBuilder: (double animationValue, double easeInValue,
            bool isExpanded, Function({bool animated}) toggleFunction) {
          return _CalendarHeader(
            isExpanded: isOpen,
            focusedDate: focusDate,
            onToggleOpen: onToggleOpen,
            onPressedPrev: onPressedPrev,
            onPressedNext: onPressedNext,
          );
        },
        content: TableCalendar(
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
          calendarStyle: CalendarStyle(
            todayTextStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorRes.gray10,
            ),
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: ColorRes.disable),
            ),
            selectedTextStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorRes.white,
            ),
            selectedDecoration: const BoxDecoration(
              color: ColorRes.primary,
              shape: BoxShape.circle,
            ),
            outsideTextStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorRes.gray5,
            ),
          ),
          onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
            logger.w(selectedDay);
            onChangedDate(selectedDay, focusedDay);
          },
          onPageChanged: (DateTime focusedDay) {
            onPageChanged(focusedDay);
          },
          selectedDayPredicate: (DateTime day) {
            /// 날짜 선택 처리.
            return currentDate == day;
          },
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
