import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/app_constant.dart';
import 'package:physical_note/app/data/feedback/feedback_api.dart';
import 'package:physical_note/app/data/feedback/model/get_feedback_response_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/ui/dialog/date_month_picker_dialog.dart';
import 'package:physical_note/app/ui/page/feedback/feedback_ui_mapper.dart';
import 'package:physical_note/app/ui/page/feedback/items/feedback_schedule_item_ui_state.dart';
import 'package:physical_note/app/ui/page/main/main_screen.dart';
import 'package:physical_note/app/ui/widgets/custom_calendar/expansion_calendar_ui_state.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';
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
  var monthlySchedule = <FeedbackScheduleItemUiState>[].obs;

  /// 오늘 일정.
  var todaySchedule = <FeedbackScheduleItemUiState>[].obs;

  /// 스크롤 상단으로 이동.
  void scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  /// 날짜 싱크 맞추기.
  void syncDate(DateTime date) {
    calendarUiState.value.focusedDate = date;
    calendarUiState.refresh();
    _loadApi();
  }

  /// 날짜 업데이트.
  void _updateDate(DateTime date) {
    final mainController = Get.find<MainScreenController>();
    mainController.syncDate(date);
  }

  /// 날짜 변경.
  void onChangedDate(DateTime newDate) {
    _updateDate(newDate);
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
    _updateDate(newFocusDate);
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
    final newDate = DateTime(currentFocusedDate.year,
        currentFocusedDate.month - 1, currentFocusedDate.day);
    _updateDate(newDate);
  }

  /// 달력 - 다음 달 클릭.
  void onPressedCalendarNext() {
    final currentFocusedDate = calendarUiState.value.focusedDate;
    final newDate = DateTime(currentFocusedDate.year,
        currentFocusedDate.month + 1, currentFocusedDate.day);
    _updateDate(newDate);
  }

  /// API 조회.
  Future _loadApi() async {
    setLoading(true);
    final feedbackApi = Get.find<FeedbackAPI>();
    final date =
        calendarUiState.value.focusedDate.toFormattedString('yyyy-MM-dd');
    final response = await feedbackApi.getFeedback(date);

    if (response is GetFeedbackResponseModel) {
      setFeedback(response);
    } else {
      // wellnessId.value = null;
      final message =
          (response as ServerResponseFailModel?)?.devMessage ?? "서버 에러";
      showToast(message);
      setFeedback(null); // 값 초기화
    }

    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);
  }
}
