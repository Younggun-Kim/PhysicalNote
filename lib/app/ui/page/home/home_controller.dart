// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/home/home_api.dart';
import 'package:physical_note/app/config/constant/hooper_index_status.dart';
import 'package:physical_note/app/data/home/model/get_home_response_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/dialog/clanedar_dialog/calendar_dialog.dart';
import 'package:physical_note/app/ui/page/home/home_ui_mapper.dart';
import 'package:physical_note/app/ui/page/home/item/home_injury_check_item/home_injury_check_item_ui_state.dart';
import 'package:physical_note/app/ui/page/home/model/home_statistics_chart_model.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_direction_type.dart';
import 'package:physical_note/app/ui/page/main/main_screen.dart';
import 'package:physical_note/app/ui/page/my_information/my_information_args.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'item/home_training_balance_item/home_training_balance_type.dart';
import 'item/home_workout_intensity_chart/home_workout_intensity_chart_ui_state.dart';
import 'model/home_urine_model.dart';

class HomeController extends BaseController {
  /// 스크롤 컨트롤러.
  final scrollController = ScrollController();

  /// 운동 Id.
  var workoutId = (null as int?);

  /// 엘리트 여부.
  var isElite = (null as bool?);

  /// 유저 이미지 URL
  var userImageUrl = "".obs;

  /// 유저 클럽 이름.
  var userClub = "".obs;

  /// 유저 클럽 코치 이름
  var userClubCoach = "".obs;

  /// 유저 이름.
  var userName = "".obs;

  /// 나의 상태 날짜.
  var myStateDate = DateTime.now().obs;

  /// 나의 상태 페이지 스크롤 컨트롤러.
  var myStatePageController = PageController(initialPage: 0).obs;

  /// 나의 상태 페이지 버튼 명
  late var myStatePageButtonName = StringRes.next.tr.obs;

  /// 후퍼인덱스.
  Rx<HooperIndexData?> hooperIndexData = (null as HooperIndexData?).obs;

  /// 부상 위험도.
  var risk = (null as int?).obs;

  var riskPercent = (null as int?).obs;

  /// 소변검사.
  Rx<HomeUrineModel?> urineData = (null as HomeUrineModel?).obs;

  /// 운동강도 - 축구.
  var workoutIntensitySports =
      HomeWorkoutIntensityChartUiState(name: StringRes.sports.tr, value: 6.5)
          .obs;

  /// 운동강도 - 피지컬.
  var workoutIntensityPhysical =
      HomeWorkoutIntensityChartUiState(name: StringRes.physical.tr, value: 6.5)
          .obs;

  /// 운동 강도 목록.
  var workoutIntensityList = <HomeWorkoutIntensityChartUiState>[].obs;

  /// 통계 - 주간 / 월간
  var isWeekly = true.obs;

  /// 통계 - 주간.
  var weeklyDataList = <HomeStatisticsChartModel>[].obs;

  /// 통계 - 월간.
  var monthlyDataList = <HomeStatisticsChartModel>[].obs;

  /// 운동시간 - 오늘의 시간.
  var workoutTodayTime = "".obs;

  /// 운동시간 - 어제와 비교 시간.
  var workoutYesterdayCompareTime = "".obs;

  /// 운동시간 - 이번주.
  var workoutThisWeek = 0.obs;

  /// 운동시간 - 이번주 상태
  var workoutThisWeekStatus = HomeTrainingBalanceType.none.obs;

  /// 운동시간 - 지난주.
  var workoutLastWeek = 0.obs;

  /// 운동시간 - 이번주 상태
  var workoutLastWeekStatus = HomeTrainingBalanceType.none.obs;

  /// 운동시간 - 지난4주.
  var workoutLastFourWeek = 0.obs;

  /// 운동시간 - 이번주 상태
  var workoutLastFourWeekStatus = HomeTrainingBalanceType.none.obs;

  /// 운동시간 - 지난8주.
  var workoutLastEightWeek = 0.obs;

  /// 운동시간 - 이번주 상태
  var workoutLastEightWeekStatus = HomeTrainingBalanceType.none.obs;

  /// 부상 체크 목록.
  late var injuryCheckList = <HomeInjuryCheckItemUiState>[].obs
    ..listen((p0) {
      _setHumanMuscleColor();
    });

  /// 사람 근육 앞모습.
  var _humanFrontOriginImage = "";
  var humanFrontImage = "".obs;

  /// 사람 근육 뒷모습.
  var _humanBackOriginImage = "";
  var humanBackImage = "".obs;

  @override
  void onInit() async {
    super.onInit();
    await _loadHumanMuscleImage();
  }

  /// 유저 정보 편집 클릭.
  void onPressedUserEdit() async {
    final args = MyInformationArgs(
      isEnteredFromHome: true,
    );
    final result = await Get.toNamed(RouteType.MY_INFORMATION, arguments: args);

    if (result is bool && result == true) {
      loadHome();
    }
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

  /// 홈 로딩.
  Future loadHome() async {
    final homeApi = Get.find<HomeAPI>();
    final recordDate = myStateDate.value.toFormattedString("yyyy-MM-dd");
    final response = await homeApi.getHome(recordDate);

    if (response is GetHomeResponseModel) {
      setScreenData(response);
    } else {
      final message =
          (response as ServerResponseFailModel?)?.devMessage ?? "서버 에러";
      showToast(message);
      setScreenData(null);
    }
  }

  /// 나의상태 - 달력 클릭.
  Future<void> onPressedCalendar() async {
    final response = await Get.dialog(
      CalendarDialog(
        currentDate: myStateDate.value,
        focusedDate: myStateDate.value,
      ),
    );

    final newDateTime = response as DateTime?;

    if (newDateTime != null && myStateDate.value != newDateTime) {
      final mainController = Get.find<MainScreenController>();
      mainController.syncDate(newDateTime);
    }
  }

  /// 주간 / 월간 클릭.
  void onPressedMonthlyOrWeekly(bool weekly) {
    isWeekly.value = weekly;
  }

  /// 스크롤 상단으로 이동.
  void scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  /// 날짜 싱크 맞추기.
  void syncDate(DateTime date) async {
    myStateDate.value = date;
    await loadHome();
  }

  /// 사람 근육 이미지 로딩.
  Future _loadHumanMuscleImage() async {
    _humanFrontOriginImage = await MuscleUtils.loadSvgFile(Assets.humanFront);
    _humanBackOriginImage = await MuscleUtils.loadSvgFile(Assets.humanBack);

    humanFrontImage.value = _humanFrontOriginImage;
    humanBackImage.value = _humanBackOriginImage;
  }

  /// 사람 근육 선택
  void _setHumanMuscleColor() {
    final list = injuryCheckList.toList();
    if (list.isEmpty) {
      humanFrontImage.value = _humanFrontOriginImage;
      humanBackImage.value = _humanBackOriginImage;
      return;
    }

    final frontImages = list
        .where((element) => element.direction == InjuryCheckDirectionType.front)
        .toList();
    final backImages = list
        .where((element) => element.direction == InjuryCheckDirectionType.back)
        .toList();

    if (frontImages.isEmpty) {
      humanFrontImage.value = _humanFrontOriginImage;
    } else {
      var svgString = _humanFrontOriginImage;

      for (var element in frontImages) {
        final color = element.injuryLevelType?.toInjuryLevelColor();
        final bodyPart = element.bodyPart?.serverKey;
        final muscleType = element.muscleType?.serverKey;

        if (color == null || bodyPart == null || muscleType == null) {
        } else {
          final pathId = "${bodyPart}_$muscleType".toLowerCase();
          svgString = MuscleUtils.changeSvgPathColor(
            svgString,
            pathId,
            color,
          );
        }
      }

      humanFrontImage.value = svgString;
    }

    if (backImages.isEmpty) {
      humanBackImage.value = _humanBackOriginImage;
    } else {}
  }

  /// 후퍼인덱스 편집 클릭.
  void onPressedHooperIndex() {
    final mainController = Get.find<MainScreenController>();
    mainController.moveDataWellness();
  }

  /// 소변검사 편집 클릭.
  void onPressedUrine() {
    final mainController = Get.find<MainScreenController>();
    mainController.moveDataWellness();
  }

  /// 부상위험도 편집 클릭.
  void onPressedRisk() {
    final mainController = Get.find<MainScreenController>();
    mainController.moveDataWellness();
  }

  /// 운동강도 편집 클릭.
  void onPressedWorkoutIntensity() {
    final mainController = Get.find<MainScreenController>();
    mainController.moveDataIntensity();
  }

  /// 운동시간 편집 클릭.
  void onPressedWorkoutTime() {
    final mainController = Get.find<MainScreenController>();
    mainController.moveDataIntensity();
  }

  /// 부상체크 편집 클릭.
  void onPressedInjuryCheckEdit(HomeInjuryCheckItemUiState uiState) {
    final mainController = Get.find<MainScreenController>();
    mainController.moveDataInjuryDetail(uiState);
  }
}
