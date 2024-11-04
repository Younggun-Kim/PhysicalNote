import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/index.dart';
import 'package:physical_note/app/config/constant/urine_status_type.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/home/home_api.dart';
import 'package:physical_note/app/data/home/model/home_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/resources/strings/translations.dart';
import 'package:physical_note/app/ui/dialog/intensity_noti/intensity_noti.dart';
import 'package:physical_note/app/ui/page/history/type/history_tab_type.dart';
import 'package:physical_note/app/ui/page/home/home_ui_mapper.dart';
import 'package:physical_note/app/ui/page/home/items/today_training/home_today_training_item_ui_state.dart';
import 'package:physical_note/app/ui/page/injury_detail/injury_detail.dart';
import 'package:physical_note/app/ui/page/intensity_detail/intensity_detail.dart';
import 'package:physical_note/app/ui/page/main/main_screen.dart';
import 'package:physical_note/app/ui/page/my_information/my_information_args.dart';
import 'package:physical_note/app/ui/page/wellness_detail/wellness_detail.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'items/injury/home_injury_item_ui_state.dart';

/// Home 컨트롤러
class HomeController extends BaseController {
  @override
  void onReady() {
    _loadApi();
    super.onReady();
  }

  /// 유저 - 이미지
  final userImage = (null as String?).obs;

  /// 유저 - 이름
  final userName = (null as String?).obs;

  /// 유저 - 팀 / 코치
  final userTeamAndCoach = (null as String?).obs;

  /// 오늘의 훈련 스크롤 컨트롤러
  final todayTrainingController = PageController();

  /// 오늘 훈련 목록
  final todayTrainingItems = <HomeTodayTrainingItemUiState>[].obs;

  /// 부상위험도 - 설명
  final riskDescription = ''.obs;

  /// 부상위험도 - 수치
  final riskValue = (null as int?).obs;

  /// 부상위험도 - %
  final riskPercent = (null as int?).obs;

  /// 웰리니스 - 후퍼인덱스 - 평균
  final hooperIndexAverage = (null as int?).obs;

  /// 웰리니스 - 후퍼인덱스 - 수면의질
  final hooperIndexSleep = (null as int?).obs;

  /// 웰리니스 - 후퍼인덱스 - 스트레스
  final hooperIndexStress = (null as int?).obs;

  /// 웰리니스 - 후퍼인덱스 - 피로
  final hooperIndexFatigue = (null as int?).obs;

  /// 웰리니스 - 후퍼인덱스 - 근육통
  final hooperIndexMuscleSoreness = (null as int?).obs;

  /// 웰리니스 - 소변상태
  final urine = UrineStatusType.none.obs;

  /// 웰리니스 - 소변상태 - 설명
  final urineDescription = ''.obs;

  /// 웰리니스 - 공복몸무게
  final emptyWeight = (null as double?).obs;

  /// 웰리니스 - 공복몸무게 차이
  final differenceWeight = (null as String?).obs;

  /// 웰리니스 - 체지방
  final bmi = (null as double?).obs;

  /// 운동강도 - 시간
  final intensityTime = (null as String?).obs;

  /// 운동강도 - 스포츠
  final intensitySports = 0.0.obs;

  /// 운동강도 - 피지컬
  final intensityPhysical = 0.0.obs;

  /// 부상현황
  final injuryList = <HomeInjuryItemUiState>[].obs;

  /// 운동강도 노티 목록
  final intensityNoti = <IntensityType>[].obs;

  /// MainScreen에서 화면 전환 시 필요
  void scrollToTop() {}

  /// MainScreen에서 화면 전환 후 처리할 동작
  void handleMainTabChanged() async {
    if (intensityNoti.isEmpty) {
      return;
    }

    Get.put(IntensityNotiController());
    final isUpdated = await Get.bottomSheet(
      IntensityNotiBottomSheet(
        isPhysicalVisible: intensityNoti.any(
          (IntensityType e) => e.isPhysical,
        ),
        isSportsVisible: intensityNoti.any(
          (IntensityType e) => !e.isPhysical,
        ),
      ),
    );
    Get.delete<IntensityNotiController>();

    if (isUpdated is bool) {
      _loadApi();
    }
  }

  Future<void> onRefresh() async {
    _loadApi();
  }

  /// 내정보 화면으로 이동
  void onPressedUserEditButton() async {
    final args = MyInformationArgs(
      isEnteredFromHome: true,
    );

    final result = await Get.toNamed(
      RouteType.MY_INFORMATION,
      arguments: args,
    );

    if (result is bool && result == true) {
      _loadApi();
    }
  }

  /// 웰리니스 기록으로 이동
  void onPressedWellnessWriteButton() async {
    final args = WellnessDetailArgs(
      wellnessId: null,
      recordDate: DateTime.now(),
    );

    final response = await Get.toNamed(
      RouteType.WELLNESS_DETAIL,
      arguments: args,
    );

    if (response is bool && response) {
      _loadApi();
    }
  }

  /// 운동강도 기록으로 이동
  void onPressedIntensityWriteButton() async {
    final args = IntensityDetailArgs(
      recordDate: DateTime.now(),
    );

    final result = await Get.toNamed(
      RouteType.INTENSITY_DETAIL,
      arguments: args,
    );

    if (result is bool && result) {
      _loadApi();
    }
  }

  /// 부상체크 기록으로 이동
  void onPressedInjuryWriteButton() async {
    final args = InjuryDetailArgs(
      injuryId: null,
      recordDate: DateTime.now(),
    );

    final result = await Get.toNamed(
      RouteType.INJURY_DETAIL,
      arguments: args,
    );

    if (result is bool && result) {
      _loadApi();
    }
  }

  /// 이력 - 웰리니스 탭으로 이동
  void onPressedWellnessMore() {
    _moveHistory(HistoryTabType.wellness);
  }

  /// 이력 - 운동강도 탭으로 이동
  void onPressedIntensityMore() {
    _moveHistory(HistoryTabType.intensity);
  }

  /// 이력 - 부상체크 탭으로 이동
  void onPressedInjuryMore() {
    _moveHistory(HistoryTabType.injury);
  }

  void _moveHistory(HistoryTabType tab) {
    final mainController = Get.find<MainScreenController>();
    mainController.moveHistory(tab);
  }

  /// API - 홈 조회
  Future<void> _loadApi() async {
    setLoading(true);
    final homeApi = Get.find<HomeAPI>();
    final recordDate = DateTime.now().toFormattedString("yyyy-MM-dd");
    final response = await homeApi.getHome(recordDate);

    if (response is GetHomeResponseModel) {
      setScreen(response);

      if (!Get.isRegistered<IntensityNotiController>()) {
        handleMainTabChanged();
      }
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
      setScreen(null);
    }

    setLoading(false);
  }
}
