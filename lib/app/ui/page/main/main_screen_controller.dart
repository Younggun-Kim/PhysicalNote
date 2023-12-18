import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/data/data_controller.dart';
import 'package:physical_note/app/ui/page/feedback/feedback.dart';
import 'package:physical_note/app/ui/page/home/home.dart';
import 'package:physical_note/app/ui/page/main/main_ui_state.dart';
import 'package:physical_note/app/utils/getx/base_main_controller.dart';
import 'package:physical_note/app/utils/getx/utils_getx.dart';

import 'main_tab_index.dart';

class MainScreenController extends BaseMainController<MainUiState> {
  @override
  final Rx<MainUiState> uiState = MainUiState().obs;

  /// 메인 탭 인덱스 변경.
  void setTabIndex(MainTabIndex tabIndex) {
    unFocus();
    if (uiState.value.tabIndex == tabIndex) {
      scrollToTop(tabIndex);
    } else {
      uiState.value.tabIndex = tabIndex;
      uiState.refresh();
    }
  }

  /// 특정 탭의 스크롤을 최상단으로 이동.
  void scrollToTop(MainTabIndex tabIndex) {
    switch (tabIndex) {
      case MainTabIndex.home:
        final isRegistered = Get.isRegistered<HomeController>();
        if (isRegistered) {
          final controller = Get.find<HomeController>();
          controller.scrollToTop();
        }
        break;
      case MainTabIndex.data:
        final isRegistered = Get.isRegistered<DataController>();
        if (isRegistered) {
          final controller = Get.find<DataController>();
          controller.scrollToTop();
        }
        break;
      case MainTabIndex.feedback:
        final isRegistered = Get.isRegistered<FeedbackController>();
        if (isRegistered) {
          final controller = Get.find<FeedbackController>();
          controller.scrollToTop();
        }
        break;
    }
  }

  /// 홈으로 이동.
  void moveHome() {
    setTabIndex(MainTabIndex.home);
  }
}
