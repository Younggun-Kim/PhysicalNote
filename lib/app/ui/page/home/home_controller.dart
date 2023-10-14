import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/user/user_storage.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

class HomeController extends BaseController {
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
      Get.toNamed(RouteType.INFORMATION_REGISTRATION);
    }
  }
}
