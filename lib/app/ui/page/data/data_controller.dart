import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/dialog/date_month_picker_dialog.dart';
import 'package:physical_note/app/ui/page/data/data_menu_type.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

class DataController extends BaseController {
  /// 스크롤 컨트롤러.
  final scrollController = ScrollController();

  /// 페이지 컨트롤러.
  var pageController = PageController(initialPage: 0).obs;

  /// 날짜.
  var date = DateTime.now().obs;

  /// 포커스 날짜.
  var focusedDate = DateTime.now().obs;

  /// 달력 오픈 여부.
  var isCalendarOpen = true.obs;

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
    date.value = newDate;
    focusedDate.value = newFocusDate;
  }

  /// 년 클릭
  Future onPressedYear() async {
    final response = await Get.dialog(
      DateYearMonthPickerDialog(
        initialDate: date.value,
        minimumDate: DateTime.utc(1980, 1, 1),
        maximumDate: DateTime.utc(2050, 12, 31),
      ),
    );

    final newDateTime = response as DateTime?;

    if (newDateTime != null && date.value != newDateTime) {
      date.value = newDateTime;
      focusedDate.value = newDateTime;

      // TODO: 여기서 리프레ㅅ
      // await loadHome();
    }
  }

  /// 달력 - 월 변경.
  void onPageChanged(DateTime newFocusDate) {
    focusedDate.value = newFocusDate;
  }

  /// 달력 - 폴딩
  void onToggleOpen() {
    final isOpen = !isCalendarOpen.value;
    isCalendarOpen.value = isOpen;
  }

  /// 달력 - 이전 달 클릭.
  void onPressedCalendarPrev() {
    final currentFocusedDate = focusedDate.value;
    focusedDate.value = DateTime(currentFocusedDate.year,
        currentFocusedDate.month - 1, currentFocusedDate.day);
  }

  /// 달력 - 다음 달 클릭.
  void onPressedCalendarNext() {
    final currentFocusedDate = focusedDate.value;
    focusedDate.value = DateTime(currentFocusedDate.year,
        currentFocusedDate.month + 1, currentFocusedDate.day);
  }

  /// 메뉴 선택.
  void onTapMenu(DataMenuType type) {
    menu.value = type;
    pageController.value.jumpToPage(type.index);
  }
}
