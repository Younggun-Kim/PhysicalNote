import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/app_constant.dart';
import 'package:physical_note/app/ui/dialog/date_month_picker_dialog.dart';
import 'package:physical_note/app/ui/page/data/data_menu_type.dart';
import 'package:physical_note/app/ui/widgets/custom_calendar/expansion_calendar_ui_state.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

class DataController extends BaseController {
  /// 스크롤 컨트롤러.
  final scrollController = ScrollController();

  /// 페이지 컨트롤러.
  var pageController = PageController(initialPage: 0).obs;

  late var calendarUiState = ExpansionCalendarUiState(
    isExpanded: true,
    currentDate: DateTime.now(),
    focusedDate: DateTime.now(),
  ).obs;

  /// 메뉴.
  var menu = DataMenuType.wellness.obs;

  /// 스크롤 상단으로 이동.
  void scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  /// 날짜 변경.
  void onChangedDate(DateTime newDate, DateTime newFocusDate) {
    // calendarUiState.value.currentDate = newDate;
    calendarUiState.value.focusedDate = newDate;
    calendarUiState.refresh();
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
        calendarUiState.value.currentDate != newDateTime) {
      calendarUiState.value.currentDate = newDateTime;
      calendarUiState.value.focusedDate = newDateTime;
      calendarUiState.refresh();

      // TODO: 여기서 리프레ㅅ
      // await loadHome();
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

  /// 메뉴 선택.
  void onTapMenu(DataMenuType type) {
    menu.value = type;
    pageController.value.jumpToPage(type.index);
  }
}
