import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

class InformationRegistrationGuideController extends BaseController {
  /// 정보등록 하기 클릭.
  void onPressedButton() {
    Get.offAndToNamed(RouteType.INFORMATION_REGISTRATION);
  }
}
