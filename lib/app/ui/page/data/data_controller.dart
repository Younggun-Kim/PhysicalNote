import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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
  var focusDate = DateTime.now().obs;

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
    focusDate.value = newFocusDate;
  }

  /// 메뉴 선택.
  void onTapMenu(DataMenuType type) {
    menu.value = type;
    pageController.value.jumpToPage(type.index);
  }
}
