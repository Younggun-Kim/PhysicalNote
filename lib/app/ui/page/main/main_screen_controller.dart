import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/data/wellness/wellness_api.dart';
import 'package:physical_note/app/ui/page/feedback/feedback.dart';
import 'package:physical_note/app/ui/page/history/history.dart';
import 'package:physical_note/app/ui/page/history/type/history_tab_type.dart';
import 'package:physical_note/app/ui/page/home/home.dart';
import 'package:physical_note/app/ui/page/main/main_ui_state.dart';
import 'package:physical_note/app/utils/getx/base_main_controller.dart';
import 'package:physical_note/app/utils/link/in_link.dart';
import 'package:physical_note/app/utils/link/model/link_data.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'main_tab_index.dart';

class MainScreenController extends BaseMainController<MainUiState> {
  @override
  void onReady() async {
    route();
    super.onReady();
  }

  /// 페이지 라우팅.
  void route() async {
    try {
      final fcmMessage = await FirebaseMessaging.instance.getInitialMessage();

      if (fcmMessage != null) {
        var inLink = Get.find<InLink>();
        inLink.open(fcmMessage.toLinkData());
      }
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  final Rx<MainUiState> uiState = MainUiState().obs;

  /// 메인 탭 인덱스 변경.
  Future setTabIndex({
    required MainTabIndex tabIndex,
  }) async {
    unFocus();

    /// 탭 변경
    changeTab(tabIndex: tabIndex);

    /// 탭 변경 후 동작
    afterTabChange(tabIndex: tabIndex);
  }

  void checkBindings() {
    if (!Get.isRegistered<WellnessAPI>()) {
      Get.lazyPut(() => WellnessAPI());
    }
    if (!Get.isRegistered<HistoryController>()) {
      Get.lazyPut(() => HistoryController());
    }
    if (!Get.isRegistered<FeedbackController>()) {
      Get.lazyPut(() => FeedbackController());
    }
  }

  void changeTab({
    required MainTabIndex tabIndex,
  }) {
    checkBindings();

    if (uiState.value.tabIndex == tabIndex) {
      scrollToTop(tabIndex);
    } else {
      uiState.value.tabIndex = tabIndex;
      uiState.refresh();
    }
  }

  void afterTabChange({
    required MainTabIndex tabIndex,
  }) {
    /// OCP 위배 변경 필요
    switch (tabIndex) {
      case MainTabIndex.home:
        final isRegistered = Get.isRegistered<HomeController>();
        if (isRegistered) {
          final controller = Get.find<HomeController>();
          controller.handleMainTabChanged();
        }
        break;
      case MainTabIndex.history:
        break;
      case MainTabIndex.feedback:
        break;
    }
  }

  /// Refresh
  void onRefresh(MainTabIndex tabIndex) {
    switch (tabIndex) {
      case MainTabIndex.home:
        final isRegistered = Get.isRegistered<HomeController>();
        if (isRegistered) {
          final controller = Get.find<HomeController>();
          controller.onRefresh();
        }
        break;
      case MainTabIndex.history:
        final isRegistered = Get.isRegistered<HistoryController>();
        if (isRegistered) {
          final controller = Get.find<HistoryController>();
          controller.onRefresh();
        }
        break;
      case MainTabIndex.feedback:
        final isRegistered = Get.isRegistered<FeedbackController>();
        if (isRegistered) {
          final controller = Get.find<FeedbackController>();
          controller.onRefresh();
        }
        break;
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
      case MainTabIndex.history:
        final isRegistered = Get.isRegistered<HistoryController>();
        if (isRegistered) {
          final controller = Get.find<HistoryController>();
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
    setTabIndex(tabIndex: MainTabIndex.home);
  }

  /// 이력탭으로 이동.
  void moveHistory(HistoryTabType tab) {
    setTabIndex(tabIndex: MainTabIndex.history);

    /// 이력 탭내의 탭 이동
    final historyController = Get.find<HistoryController>();
    historyController.changeTab(tab.index);
  }

  /// 피드백탭으로 이동
  void moveFeedback(DateTime? recordDate) {
    setTabIndex(tabIndex: MainTabIndex.feedback);

    if (recordDate != null) {
      final feedbackController = Get.find<FeedbackController>();
      feedbackController.onChangedDate(recordDate);
    }
  }
}
