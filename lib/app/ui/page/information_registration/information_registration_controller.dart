import 'package:get/get.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

/// 정보등록 컨트롤러.
class InformationRegistrationController extends BaseController {

  /// 아마추어 선택 여부.
  var isAmateur = false.obs;

  /// 엘리트 선택 여부.
  var isElite = false.obs;

  /// 아마추어 클릭.
  void onPressedAmateur() {
    logger.i("아마추어 클릭");
    isAmateur.value = true;
    isElite.value = false;
  }

  /// 엘리트 클릭.
  void onPressedElite() {
    logger.i("엘리트 클릭");
    isAmateur.value = false;
    isElite.value = true;
  }
}