import 'package:get/get.dart';
import 'package:physical_note/app/utils/base/getx/base_controller.dart';

class TermController extends BaseController {

  /// 네비게이션 뒤로가기 클릭.
  void onPressedNavigationBackButton() {
    Get.back();
  }
}
