import 'package:get/get.dart';
import 'package:physical_note/app/routes/routes.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';
import 'package:physical_note/app/utils/link/link.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class TermController extends BaseController {
  /// 서비스 이용 약관.
  var checkService = false.obs;

  /// 개인정보 수집 및 이용동의.
  var checkPrivacy = false.obs;

  /// 전체동의.
  late final _checkAll = CombineLatestStream([
    checkService.behaviorStream,
    checkPrivacy.behaviorStream,
  ], (values) => values.every((element) => element));

  late final checkAll = _checkAll.toObs(false);

  /// 전체동의 클릭.
  void onToggleAll() {
    final isOn = !checkAll.value;
    checkService.value = isOn;
    checkPrivacy.value = isOn;
  }

  /// 서비스 이용약관 클릭.
  void onToggleService() {
    checkService.toggle();
  }

  /// 서비스 이용약관 웹 페이지 이동.
  void onPressedService() {
    Get.find<OutLink>().moveServiceTerm();
  }

  /// 개인정보 클릭.
  void onTogglePrivacy() {
    checkPrivacy.toggle();
  }

  /// 서비스 이용약관 웹 페이지 이동.
  void onPressedPrivacy() {
    Get.find<OutLink>().movePrivacyTerm();
  }

  /// 다음 버튼 클릭.
  void onPressedNextButton() {
    Get.toNamed(RouteType.SIGN_UP);
  }
}
