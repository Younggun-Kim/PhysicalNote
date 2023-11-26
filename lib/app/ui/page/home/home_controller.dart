import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/hooper_index.dart';
import 'package:physical_note/app/data/user/user_storage.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'home_workout_intensity_chart/home_workout_intensity_chart_ui_state.dart';

class HomeController extends BaseController {
  /// 유저 이미지 URL
  var userImageUrl = "".obs;

  /// 유저 클럽 이름.
  var userClub = "여기저기".obs;

  /// 유저 클럽 코치 이름
  var userClubCoach = "김코치".obs;

  /// 유저 이름.
  var userName = "코너".obs;

  /// 후퍼인덱스.
  // ignore: unnecessary_cast
  Rx<HooperIndexData?> hooperIndexData = (null as HooperIndexData?).obs;

  /// 공복 몸무게.
  var emptyWeight = "".obs;

  /// 비교 몸무게 퍼센트
  var weightPercent = 0.obs;

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

  @override
  void onInit() {
    moveInformationRegistration();
    super.onInit();
  }

  /// 정보 등록 화면으로 이동.
  Future<void> moveInformationRegistration() async {
    final userStorage = UserStorage();

    if (!userStorage.isRegisteredInformation.val) {
      // 정보등록으로 이동
      await 1.delay();
      await Get.toNamed(RouteType.INFORMATION_REGISTRATION);
    } else {
      await 1.delay();

      hooperIndexData.value = HooperIndexData(
        sleep: HooperIndexStatusGood(),
        stress: HooperIndexStatusDangerous(),
        fatigue: HooperIndexStatusWarning(),
        musclePain: HooperIndexStatusNormal(),
      );
      emptyWeight.value = "5.5";
    }
  }

  /// 유저 정보 편집 클릭.
  void onPressedUserEdit() {
    logger.i("유저 정보 편집 클릭");
    _logout();
  }

  /// 홈 다음 버튼 클릭.
  void onPressedNextButton() {
    logger.i("다음 버튼 클릭!");
  }

  /// 로그아웃.
  void _logout() {
    final userStorage = UserStorage();

    /// 저장된 토근 삭제
    userStorage.apiKey.val = "";

    /// 로그인으로 이동.
    Get.offAndToNamed(RouteType.LOGIN);
  }
}
