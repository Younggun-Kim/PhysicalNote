import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/app_constant.dart';
import 'package:physical_note/app/ui/dialog/date_month_picker_dialog.dart';
import 'package:physical_note/app/ui/page/feedback/items/feedback_schedule_item_tag_type.dart';
import 'package:physical_note/app/ui/page/feedback/items/feedback_schedule_item_ui_state.dart';
import 'package:physical_note/app/ui/widgets/custom_calendar/expansion_calendar_ui_state.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';
import 'package:physical_note/app/utils/utils.dart';

class FeedbackController extends BaseController {
  /// 스크롤 컨트롤러.
  final scrollController = ScrollController();

  /// 캘린더 Ui State.
  late var calendarUiState = ExpansionCalendarUiState(
    isExpanded: false,
    currentDate: DateTime.now(),
    focusedDate: DateTime.now(),
  ).obs;

  /// 오늘의 피드백.
  var todayFeedback = "".obs;

  /// 월간 주요 일정.
  var monthlySchedule = <FeedbackScheduleItemUiState>[
    FeedbackScheduleItemUiState(
      teamName: "FC",
      period: "12월 18일(목)",
      time: "09:30 ~ 11:00 ",
      place: "강릉종합운동장",
    ),
    FeedbackScheduleItemUiState(
      teamName: "FC",
      period: "12월 18일(목)",
      time: "09:30 ~ 11:00 ",
      place: "강릉종합운동장",
    ),
    FeedbackScheduleItemUiState(
      teamName: "FC",
      period: "12월 18일(목)",
      time: "09:30 ~ 11:00 ",
      place: "강릉종합운동장",
    ),
    FeedbackScheduleItemUiState(
      teamName: "FC",
      period: "12월 18일(목)",
      time: "09:30 ~ 11:00 ",
      place: "강릉종합운동장",
    ),
  ].obs;

  /// 오늘 일정.
  var todaySchedule = <FeedbackScheduleItemUiState>[
    FeedbackScheduleItemUiState(
      tag: FeedbackScheduleItemTagType.field,
      name: "전술훈련",
      time: "09:30 ~ 11:00 ",
      place: "강릉종합운동장",
      training: "전술훈련",
    ),
    FeedbackScheduleItemUiState(
      tag: FeedbackScheduleItemTagType.physical,
      name: "전술훈련",
      time: "09:30 ~ 11:00 ",
      place: "강릉종합운동장",
      training: "전술훈련",
      imageUrl: "https://picsum.photos/200/300",
    ),
  ].obs;

  /// 스크롤 상단으로 이동.
  void scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  /// 날짜 변경.
  void onChangedDate(DateTime newDate) {
    calendarUiState.value.focusedDate = newDate;
    calendarUiState.refresh();

    // _loadApi();
  }

  /// 년 클릭
  Future onPressedYear() async {
    final response = await Get.dialog(
      DateYearMonthPickerDialog(
        initialDate: calendarUiState.value.currentDate,
        minimumDate: AppConstant.CALENDAR_MIN_DATE,
        maximumDate: AppConstant.CALENDAR_MAX_DATE,
      ),
    );

    final newDateTime = response as DateTime?;

    if (newDateTime != null &&
        calendarUiState.value.focusedDate != newDateTime) {
      onChangedDate(newDateTime);
    }
  }

  /// 달력 - 월 변경.
  void onPageChanged(DateTime newFocusDate) {
    calendarUiState.value.focusedDate = newFocusDate;
    calendarUiState.refresh();
  }

  /// 달력 - 폴딩
  void onToggleCalendarExpanded() {
    final isExpanded = !calendarUiState.value.isExpanded;
    calendarUiState.value.isExpanded = isExpanded;
    calendarUiState.refresh();
  }

  /// 달력 - 이전 달 클릭.
  void onPressedCalendarPrev() {
    final currentFocusedDate = calendarUiState.value.focusedDate;
    calendarUiState.value.focusedDate = DateTime(currentFocusedDate.year,
        currentFocusedDate.month - 1, currentFocusedDate.day);
    calendarUiState.refresh();
  }

  /// 달력 - 다음 달 클릭.
  void onPressedCalendarNext() {
    final currentFocusedDate = calendarUiState.value.focusedDate;
    calendarUiState.value.focusedDate = DateTime(currentFocusedDate.year,
        currentFocusedDate.month + 1, currentFocusedDate.day);
    calendarUiState.refresh();
  }
}
