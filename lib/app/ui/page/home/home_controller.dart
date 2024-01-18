// ignore_for_file: unnecessary_cast

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/home/home_api.dart';
import 'package:physical_note/app/config/constant/hooper_index_status.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/dialog/clanedar_dialog/calendar_dialog.dart';
import 'package:physical_note/app/ui/page/home/home_ui_mapper.dart';
import 'package:physical_note/app/ui/page/home/item/home_injury_check_item/home_injury_check_item_ui_state.dart';
import 'package:physical_note/app/ui/page/home/model/home_statistics_chart_model.dart';
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
  Rx<List<HomeInjuryCheckItemUiState>?> injuryCheckList =
      (null as List<HomeInjuryCheckItemUiState>?).obs;

  @override
  void onInit() {
    super.onInit();
    loadHome();
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
  Future<void> loadHome() async {
    final homeApi = Get.find<HomeAPI>();
    final recordDate = myStateDate.value.toFormattedString("yyyy-MM-dd");
    final response = await homeApi.getHome(recordDate);

    setScreenData(response);
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
      myStateDate.value = newDateTime;
      await loadHome();
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
}
