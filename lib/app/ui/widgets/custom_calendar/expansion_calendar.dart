import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/constants.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:table_calendar/table_calendar.dart';

import 'expansion_calendar_ui_state.dart';

/// 확장형 달력.
class ExpansionCalendar extends StatelessWidget {
  final ExpansionCalendarUiState uiState;

  /// 년도 클릭 이벤트.
  final Function() onPressedYear;

  /// 확장 토글 이벤트.
  final Function() onToggleExpanded;

  /// 이전 달 클릭 이벤트.
  final Function() onPressedPrev;

  /// 다음 달 클릭 이벤트.
  final Function() onPressedNext;

  /// 날짜 변경 이벤트.
  final Function(DateTime newDate) onChangedDate;

  /// 달력 스크롤링 이벤트.
  final Function(DateTime focusDate) onPageChanged;

  const ExpansionCalendar({
    super.key,
    required this.uiState,
    required this.onPressedYear,
    required this.onToggleExpanded,
    required this.onPressedPrev,
    required this.onPressedNext,
    required this.onChangedDate,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) => ExpansionWidget(
        initiallyExpanded: uiState.isExpanded,
        onRestoreState: (context) => uiState.isExpanded,
        titleBuilder: (double animationValue, double easeInValue,
            bool isExpanded, Function({bool animated}) toggleFunction) {
          return _CalendarHeader(
            uiState: uiState,
            onPressedYear: onPressedYear,
            onToggleExpanded: onToggleExpanded,
            onPressedPrev: onPressedPrev,
            onPressedNext: onPressedNext,
          );
        },
        content: _CalendarBody(
          uiState: uiState,
          onChangedDate: onChangedDate,
          onPageChanged: onPageChanged,
        ),
      );
}

/// 달력 헤더.
class _CalendarHeader extends StatelessWidget {
  final ExpansionCalendarUiState uiState;

  /// 년도 클릭 이벤트.
  final Function() onPressedYear;

  /// 확장 토글 이벤트.
  final Function() onToggleExpanded;

  /// 이전 달 클릭 이벤트.
  final Function() onPressedPrev;

  /// 다음 달 클릭 이벤트.
  final Function() onPressedNext;

  const _CalendarHeader({
    required this.uiState,
    required this.onPressedYear,
    required this.onToggleExpanded,
    required this.onPressedPrev,
    required this.onPressedNext,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 80,
        child: uiState.isExpanded ? closeWidget() : openWidget(),
      );

  Widget closeWidget() => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWellOver(
            onTap: () {
              onPressedYear();
            },
            child: Row(
              children: [
                Text(
                  uiState.focusedDate.year.toString(),
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
            uiState.focusedDate.toFormattedString("MM"),
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
            hint: "",
            text: StringRes.close.tr,
            onPressed: onToggleExpanded,
          )
        ],
      );


  String get displayDate => LocalizationUtil.getDateStrFromDate(
        date: uiState.focusedDate,
        koFormat: 'yy년 M월 d일',
        enFormat: 'MMMM d, yy',
      );

  Widget openWidget() => Stack(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              displayDate,
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
                  hint: "",
                  text: StringRes.open.tr,
                  onPressed: onToggleExpanded,
                ),
              ))
        ],
      );
}

class _CalendarBody extends StatelessWidget {
  final ExpansionCalendarUiState uiState;

  /// 날짜 변경 이벤트.
  final Function(DateTime newDate) onChangedDate;

  /// 달력 스크롤링 이벤트.
  final Function(DateTime focusDate) onPageChanged;

  const _CalendarBody({
    required this.uiState,
    required this.onChangedDate,
    required this.onPageChanged,
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
        firstDay: Constants.CALENDAR_MIN_DATE,
        lastDay: Constants.CALENDAR_MAX_DATE,
        // 달력 스크롤 잡아 주는 역할
        focusedDay: uiState.focusedDate,
        currentDay: uiState.currentDate,
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
          onChangedDate(selectedDay);
        },
        onPageChanged: (DateTime focusedDay) {
          onPageChanged(focusedDay);
        },
        selectedDayPredicate: (DateTime day) {
          /// 날짜 선택 처리.
          return isSameDay(uiState.focusedDate, day);
        },
      ).paddingOnly(bottom: 20);
}
