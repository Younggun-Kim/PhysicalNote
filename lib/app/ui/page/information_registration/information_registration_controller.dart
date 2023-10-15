import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

/// 정보등록 컨트롤러.
class InformationRegistrationController extends BaseController {

  /// 아마추어 선택 여부.
  var isAmateur = false.obs;

  /// 엘리트 선택 여부.
  var isElite = false.obs;

  /// 종목 클릭.
  void onPressedCategory() {
    Get.toNamed(RouteType.SEARCH_CATEGORY);
  }

  /// 아마추어 클릭.
  void onPressedAmateur() {
    isAmateur.value = true;
    isElite.value = false;
  }

  /// 엘리트 클릭.
  void onPressedElite() {
    isAmateur.value = false;
    isElite.value = true;
  }
}