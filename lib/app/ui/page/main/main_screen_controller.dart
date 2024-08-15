import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:physical_note/app/ui/page/feedback/feedback.dart';
import 'package:physical_note/app/ui/page/history/history.dart';
import 'package:physical_note/app/ui/page/home2/home.dart';
import 'package:physical_note/app/ui/page/home/item/home_injury_check_item/home_injury_check_item_ui_state.dart';
import 'package:physical_note/app/ui/page/main/main_ui_state.dart';
import 'package:physical_note/app/utils/getx/base_main_controller.dart';
import 'package:physical_note/app/utils/link/in_link.dart';
import 'package:physical_note/app/utils/link/model/link_data.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'main_tab_index.dart';

class MainScreenController extends BaseMainController<MainUiState> {
  @override
  void onInit() async {
    super.onInit();
    await loadApi();
  }

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

  /// 사람 앞모습.
  var humanFrontOriginImage = "";

  /// 사람 뒷모습.
  var humanBackOriginImage = "";

  /// 메인 탭 인덱스 변경.
  Future setTabIndex({
    required MainTabIndex tabIndex,
    bool canLoad = true,
  }) async {
    unFocus();
    if (uiState.value.tabIndex == tabIndex) {
      scrollToTop(tabIndex);
    } else {
      uiState.value.tabIndex = tabIndex;
      uiState.refresh();

      if (!canLoad) {
        return;
      }
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
          // controller.scrollToTop();
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

  /// 데이터탭으로 이동.
  void moveData() {
    /// 데이터 탭으로 이동.
    setTabIndex(tabIndex: MainTabIndex.history);
  }

  /// 데이터탭으로 이동.
  void moveDataWellness() {
    /// 데이터 탭으로 이동.
    setTabIndex(tabIndex: MainTabIndex.history, canLoad: false);

    /// 데이터 탭에서 웰리니스 메뉴로 이동.
    final historyController = Get.find<HistoryController>();
    // historyController.changeMenu(DataMenuType.wellness);
  }

  /// 데이터탭으로 이동.
  void moveDataIntensity() {
    /// 데이터 탭으로 이동.
    setTabIndex(tabIndex: MainTabIndex.history, canLoad: false);

    /// 데이터 탭에서 운동강도 메뉴로 이동.
    final historyController = Get.find<HistoryController>();
    // historyController.changeMenu(DataMenuType.intensity);
  }

  /// 데이터 탭으로 이동 및 부상체크 상세 화면으로 이동.
  void moveDataInjuryDetail(HomeInjuryCheckItemUiState uiState) async {
    /// 날짜 싱크
    final recordDate = uiState.recordDate;
    if (recordDate != null) {
      final dateTime = DateFormat('yyyy-MM-dd').parse(recordDate);
      syncDate(dateTime);
    }

    /// 데이터 탭으로 이동.
    await setTabIndex(tabIndex: MainTabIndex.history, canLoad: false);

    /// 데이터 탭에서 메뉴이동
    final historyController = Get.find<HistoryController>();
    // await historyController.changeMenu(DataMenuType.injury);

    /// 부상체크 상세 화면으로 이동.
    // historyController.onPressedEdit(uiState);
  }

  /// 날짜 싱크 맞추기.
  void syncDate(DateTime date) {
    final homeController = Get.find<HomeController>();
    final historyController = Get.find<HistoryController>();
    final feedbackController = Get.find<FeedbackController>();

    // homeController.syncDate(date);
    historyController.syncDate(date);
    feedbackController.syncDate(date);

    loadApi();
  }

  /// API - Get
  Future loadApi() async {
    final tab = uiState.value.tabIndex;

    switch (tab) {
      case MainTabIndex.history:
        final historyController = Get.find<HistoryController>();
        // await historyController.loadApi();
      case MainTabIndex.home:
        final homeController = Get.find<HomeController>();
        // await homeController.loadHome();
      case MainTabIndex.feedback:
        final feedbackController = Get.find<FeedbackController>();
        await feedbackController.loadFeedback();
    }
  }
}
