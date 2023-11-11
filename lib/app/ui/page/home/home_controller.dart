import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/user/user_storage.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

class HomeController extends BaseController {

  /// 유저 이미지 URL
  var userImageUrl = "".obs;

  /// 유저 클럽 이름.
  var userClub = "여기저기".obs;

  /// 유저 클럽 코치 이름
  var userClubCoach = "김코치".obs;

  /// 유저 이름.
  var userName = "코너".obs;

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
    }
  }
  
  void onPressedUserEdit() {
    logger.i("편집 클릭");
  }
}
