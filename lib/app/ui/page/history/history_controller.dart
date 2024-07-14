import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/widgets/custom_calendar/expansion_calendar_ui_state.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

import '../main/main_screen_controller.dart';

class HistoryController extends BaseController {
  /// 스크롤 컨트롤러.
  final scrollController = ScrollController();

  /// 캘린더 Ui State.
  late var calendarUiState = ExpansionCalendarUiState(
    isExpanded: false,
    currentDate: DateTime.now(),
    focusedDate: DateTime.now(),
  ).obs;

  var isLoaded = false;

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
    isLoaded = false;
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
}
