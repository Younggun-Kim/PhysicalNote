import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/hooper_index.dart';
import 'package:physical_note/app/data/user/user_storage.dart';
import 'package:physical_note/app/utils/utils.dart';

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
  var weightPercent = 10.obs;

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
    showToast("유저 정보 편집 클릭");
  }

  /// 홈 다음 버튼 클릭.
  void onPressedNextButton() {
    showToast("다음 버튼 클릭!");
  }
}
