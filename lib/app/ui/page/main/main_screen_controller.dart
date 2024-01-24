import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/data/data_controller.dart';
import 'package:physical_note/app/ui/page/feedback/feedback.dart';
import 'package:physical_note/app/ui/page/home/home.dart';
import 'package:physical_note/app/ui/page/home/item/home_injury_check_item/home_injury_check_item_ui_state.dart';
import 'package:physical_note/app/ui/page/main/main_ui_state.dart';
import 'package:physical_note/app/utils/getx/base_main_controller.dart';
import 'package:physical_note/app/utils/getx/utils_getx.dart';

import '../data/data_menu_type.dart';
import 'main_tab_index.dart';

class MainScreenController extends BaseMainController<MainUiState> {

  @override
  final Rx<MainUiState> uiState = MainUiState().obs;

  /// 메인 탭 인덱스 변경.
  void setTabIndex(MainTabIndex tabIndex) async {
    unFocus();
    if (uiState.value.tabIndex == tabIndex) {
      scrollToTop(tabIndex);
    } else {
      uiState.value.tabIndex = tabIndex;
      uiState.refresh();
      await loadApi();
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

  /// 데이터탭으로 이동.
  void moveData() {
    /// 데이터 탭으로 이동.
    setTabIndex(MainTabIndex.data);
  }

  /// 데이터탭으로 이동.
  void moveDataWellness() {
    /// 데이터 탭으로 이동.
    setTabIndex(MainTabIndex.data);

    /// 데이터 탭에서 웰리니스 메뉴로 이동.
    final dataController = Get.find<DataController>();
    dataController.onTapMenu(DataMenuType.wellness);
  }

  /// 데이터탭으로 이동.
  void moveDataIntensity() {
    /// 데이터 탭으로 이동.
    setTabIndex(MainTabIndex.data);

    /// 데이터 탭에서 운동강도 메뉴로 이동.
    final dataController = Get.find<DataController>();
    dataController.onTapMenu(DataMenuType.intensity);
  }

  /// 데이터 탭으로 이동 및 부상체크 상세 화면으로 이동.
  void moveDataInjuryDetail(HomeInjuryCheckItemUiState uiState) {
    /// 데이터 탭으로 이동.
    setTabIndex(MainTabIndex.data);

    /// 데이터 탭에서 메뉴이동
    final dataController = Get.find<DataController>();
    dataController.onTapMenu(DataMenuType.injury);

    /// 부상체크 상세 화면으로 이동.
    dataController.onPressedEdit(uiState);
  }

  /// 날짜 싱크 맞추기.
  void syncDate(DateTime date) {
    final homeController = Get.find<HomeController>();
    final dataController = Get.find<DataController>();
    final feedbackController = Get.find<FeedbackController>();

    homeController.syncDate(date);
    dataController.syncDate(date);
    feedbackController.syncDate(date);
  }

  /// API - Get
  Future loadApi() async {
    final tab = uiState.value.tabIndex;

    switch (tab) {
      case MainTabIndex.data:
        final dataController = Get.find<DataController>();
        await dataController.loadApi();
      case MainTabIndex.home:
        final homeController = Get.find<HomeController>();
        await homeController.loadHome();
      case MainTabIndex.feedback:
        final feedbackController = Get.find<FeedbackController>();
        await feedbackController.loadFeedback();
    }
  }
}
