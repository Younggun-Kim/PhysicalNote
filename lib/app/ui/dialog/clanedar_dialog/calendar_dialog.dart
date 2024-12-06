import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/constants.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/dialog/date_month_picker_dialog.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';
import 'package:table_calendar/table_calendar.dart';

/// 달력 다이얼로그.
class CalendarDialog extends StatefulWidget {
  final DateTime currentDate;

  final DateTime focusedDate;

  const CalendarDialog({
    super.key,
    required this.currentDate,
    required this.focusedDate,
  });

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  late DateTime currentDate;

  late DateTime focusedDate;

  @override
  void initState() {
    super.initState();
    currentDate = widget.currentDate;
    focusedDate = widget.focusedDate;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(30),
              ),
            ),
            Center(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: ColorRes.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _CalendarHeader(
                      focusedDate: focusedDate,
                      onPressedYear: _onPressedYear,
                      onPressedPrev: _onPressedPrevMonth,
                      onPressedNext: _onPressedNextMonth,
                    ),
                    const SizedBox(height: 20),
                    _CalendarBody(
                      currentDate: currentDate,
                      focusedDate: focusedDate,
                      onChangedDate: _onChangedDate,
                      onPageChanged: _onPageChanged,
                    ),
                    RoundButton(
                      text: StringRes.select.tr,
                      height: 40,
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: ColorRes.white,
                        fontWeight: FontWeight.w400,
                      ),
                      onPressed: () {
                        Get.back(result: focusedDate);
                      }, // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  /// 년 클릭.
  Future _onPressedYear() async {
    final response = await Get.dialog(
      DateYearMonthPickerDialog(
        initialDate: currentDate,
        minimumDate: Constants.CALENDAR_MIN_DATE,
        maximumDate: Constants.CALENDAR_MAX_DATE,
      ),
    );

    final newDateTime = response as DateTime?;

    if (newDateTime != null && focusedDate != newDateTime) {
      _onChangedDate(newDateTime);
    }
  }

  /// 이전 달 버튼 클릭.
  void _onPressedPrevMonth() {
    final newDate = DateTime(
      focusedDate.year,
      focusedDate.month - 1,
      focusedDate.day,
    );
    _updateFocusedDate(newDate);
  }

  /// 다음 달 버튼 클릭.
  void _onPressedNextMonth() {
    final newDate = DateTime(
      focusedDate.year,
      focusedDate.month + 1,
      focusedDate.day,
    );
    _updateFocusedDate(newDate);
  }

  /// 달력 월 변경.
  void _onPageChanged(DateTime newDate) {
    _updateFocusedDate(newDate);
  }

  /// 날짜 변경.
  void _onChangedDate(DateTime newDate) {
    _updateFocusedDate(newDate);
  }

  void _updateFocusedDate(DateTime newDate) {
    setState(() {
      focusedDate = newDate;
    });
  }
}

/// 달력 헤더.
class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDate;

  /// 년도 클릭 이벤트.
  final Function() onPressedYear;

  /// 이전 달 클릭 이벤트.
  final Function() onPressedPrev;

  /// 다음 달 클릭 이벤트.
  final Function() onPressedNext;

  const _CalendarHeader({
    required this.focusedDate,
    required this.onPressedYear,
    required this.onPressedPrev,
    required this.onPressedNext,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            InkWellOver(
              borderRadius: BorderRadius.circular(4),
              onTap: onPressedYear,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    focusedDate.toFormattedString("yy.MM"),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 16,
                      color: ColorRes.fontBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(Assets.chevronDown),
                ],
              ),
            ),
            const Spacer(),
            InkWellOver(
              borderRadius: BorderRadius.circular(20),
              onTap: onPressedPrev,
              child: RotatedBox(
                quarterTurns: 90,
                child: SvgPicture.asset(Assets.chevronRight),
              ),
            ),
            const SizedBox(width: 4),
            InkWellOver(
              borderRadius: BorderRadius.circular(20),
              onTap: onPressedNext,
              child: SvgPicture.asset(Assets.chevronRight),
            ),
          ],
        ),
      );
}

/// 달력 바디.
class _CalendarBody extends StatelessWidget {
  final DateTime currentDate;

  final DateTime focusedDate;

  /// 날짜 변경 이벤트.
  final Function(DateTime newDate) onChangedDate;

  /// 달력 스크롤링 이벤트.
  final Function(DateTime focusDate) onPageChanged;

  const _CalendarBody({
    required this.currentDate,
    required this.focusedDate,
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
        focusedDay: focusedDate,
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
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorRes.gray10,
          ),
          todayDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: ColorRes.disable),
          ),
          selectedTextStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorRes.white,
          ),
          selectedDecoration: const BoxDecoration(
            color: ColorRes.primary,
            shape: BoxShape.circle,
          ),
          outsideTextStyle: const TextStyle(
            fontSize: 16,
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
          return isSameDay(focusedDate, day);
        },
      ).paddingOnly(bottom: 30);
}
