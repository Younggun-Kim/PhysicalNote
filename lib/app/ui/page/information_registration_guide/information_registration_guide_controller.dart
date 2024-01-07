import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/ui/page/information_registration_guide/information_registration_guide_args.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

class InformationRegistrationGuideController extends BaseController {
  final args = Get.arguments as InformationRegistrationGuideArgs;

  /// 정보등록 하기 클릭.
  void onPressedButton() {
    Get.offAndToNamed(RouteType.INFORMATION_REGISTRATION);
  }
}
