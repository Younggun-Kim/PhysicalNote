// ignore_for_file: unnecessary_cast

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/home/home_api.dart';
import 'package:physical_note/app/data/hooper_index.dart';
import 'package:physical_note/app/data/user/user_storage.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/dialog/calendar_dialog.dart';
import 'package:physical_note/app/ui/page/home/home_ui_mapper.dart';
import 'package:physical_note/app/ui/page/home/item/home_injury_check_item/home_injury_check_item_ui_state.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'item/home_workout_intensity_chart/home_workout_intensity_chart_ui_state.dart';
import 'model/home_urine_model.dart';

class HomeController extends BaseController {
  /// 유저 이미지 URL
  var userImageUrl = "".obs;

  /// 유저 클럽 이름.
  var userClub = "여기저기".obs;

  /// 유저 클럽 코치 이름
  var userClubCoach = "김코치".obs;

  /// 유저 이름.
  var userName = "코너".obs;

  /// 나의 상태 날짜.
  var myStateDate = DateTime.now().obs;

  /// 나의 상태 페이지 스크롤 컨트롤러.
  var myStatePageController = PageController(initialPage: 0).obs;

  /// 나의 상태 페이지 버튼 명
  late var myStatePageButtonName = StringRes.next.tr.obs;

  /// 후퍼인덱스.
  Rx<HooperIndexData?> hooperIndexData = (null as HooperIndexData?).obs;

  /// 소변검사.
  Rx<HomeUrineModel?> urineData = (null as HomeUrineModel?).obs;

  /// 운동강도 - 축구.
  var workoutIntensitySoccer =
      HomeWorkoutIntensityChartUiState(name: "축구", value: 6.5).obs;

  /// 운동강도 - 피지컬.
  var workoutIntensityPhysical =
      HomeWorkoutIntensityChartUiState(name: "피지컬", value: 6.5).obs;

  /// 통계 - 스포츠.
  var statisticsSports = <FlSpot>[
    FlSpot(1, 1),
    FlSpot(3, 1.5),
    FlSpot(5, 1.4),
    FlSpot(7, 3.4),
    FlSpot(10, 2),
    FlSpot(12, 2.2),
    FlSpot(13, 1.8),
  ].obs;

  /// 통계 - 스포츠.
  var statisticsPhysical = <FlSpot>[
    FlSpot(1, 1),
    FlSpot(3, 2.8),
    FlSpot(7, 1.2),
    FlSpot(10, 2.8),
    FlSpot(12, 2.6),
    FlSpot(13, 3.9),
  ].obs;

  /// 부상 체크 목록.
  var injuryCheckList = <HomeInjuryCheckItemUiState>[
    HomeInjuryCheckItemUiState(level: 0, muscleName: "대퇴근", recordDate: "2023-12-08", description: "fejfioejoifjoesijfojseoifjea"),
    HomeInjuryCheckItemUiState(level: 1, muscleName: "대흉근", recordDate: "2023-12-08", description: "fejfioejoifjoesijfojseoifjea"),
    HomeInjuryCheckItemUiState(level: 2, muscleName: "대흉근", recordDate: "2023-12-08", description: "fejfioejoifjoesijfojseoifjea"),
    HomeInjuryCheckItemUiState(level: 3, muscleName: "대흉근", recordDate: "2023-12-08", description: "fejfioejoifjoesijfojseoifjea"),
    HomeInjuryCheckItemUiState(level: 4, muscleName: "대흉근", recordDate: "2023-12-08", description: "fejfioejoifjoesijfojseoifjea"),
    HomeInjuryCheckItemUiState(level: 5, muscleName: "대흉근", recordDate: "2023-12-08", description: "fejfioejoifjoesijfojseoifjea"),
    HomeInjuryCheckItemUiState(level: 6, muscleName: "", recordDate: "2023-12-08", description: "fejfioejoifjoesijfojseoifjea"),
  ].obs;

  @override
  void onInit() {
    moveInformationRegistration();
    super.onInit();
    loadHome();
  }

  /// 정보 등록 화면으로 이동.
  Future<void> moveInformationRegistration() async {
    final userStorage = UserStorage();

    if (!userStorage.isRegisteredInformation.val) {
      // 정보등록으로 이동
      await 1.delay();
      await Get.toNamed(RouteType.INFORMATION_REGISTRATION);
    }
  }

  /// 유저 정보 편집 클릭.
  void onPressedUserEdit() {
    logger.i("유저 정보 편집 클릭");
    _logout();
  }

  /// 홈 다음 버튼 클릭.
  void onPressedNextButton() {
    if (myStatePageController.value.page == 0) {
      myStatePageController.value.jumpToPage(1);
      myStatePageButtonName.value = StringRes.prev.tr;
    } else {
      myStatePageController.value.jumpToPage(0);
      myStatePageButtonName.value = StringRes.next.tr;
    }
  }

  /// 로그아웃.
  void _logout() {
    final userStorage = UserStorage();

    /// 저장된 토근 삭제
    userStorage.apiKey.val = "";

    /// 로그인으로 이동.
    Get.offAndToNamed(RouteType.LOGIN);
  }

  /// 홈 로딩.
  Future<void> loadHome() async {
    final homeApi = Get.find<HomeAPI>();
    final recordDate = myStateDate.value.toFormattedString("yyyy-MM-dd");
    final response = await homeApi.getHome(recordDate);

    setScreenData(response);
  }

  /// 나의상태 - 달력 클릭.
  Future<void> onPressedCalendar() async {
    await Get.dialog(const CalendarDialog());
  }
}
