import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

class DataController extends BaseController {
  /// 스크롤 컨트롤러.
  final scrollController = ScrollController();

  /// 페이지 컨트롤러.
  var pageController = PageController(initialPage: 0).obs;

  /// 날짜.
  Rx<DateTime?> date = DateTime.now().obs;

  /// 스크롤 상단으로 이동.
  void scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  /// 날짜 변경.
  void onChangedDate(DateTime? newDate) {
    date.value = newDate;
  }
}
