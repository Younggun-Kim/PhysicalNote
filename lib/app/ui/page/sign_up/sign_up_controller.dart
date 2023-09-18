import 'package:get/get.dart';
import 'package:physical_note/app/utils/utils.dart';

class SignUpController extends BaseController {
  /// 이름.
  final name = "".obsWithController;

  /// 이메일.
  final email = "".obsWithController;

  /// 전화번호.
  final phoneNumber = "".obsWithController;

  /// 비밀번호.
  final password = "".obsWithController;

  /// 비밀번호 확인.
  final passwordConfirm = "".obsWithController;

  /// 뒤로가기 클릭.
  void onPressedBackButton() {
    Get.back();
  }
}
