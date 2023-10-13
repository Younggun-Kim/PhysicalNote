import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class LoginController extends BaseController {
  /// 이메일 컨트롤러.
  final email = "".obsWithController;

  /// 이메일 유효성 검사.
  late final _isValidEmail = email.behaviorStream.map((event) => event.isEmail);
  late final isValidEmail = _isValidEmail.map((event) => !event).toObs(false);

  /// 패스워드 컨트롤러.
  final password = "".obsWithController;

  /// 비밀번호 유효성 검사.'
  late final _isValidPassword =
      password.behaviorStream.map((event) => Regex.isPassword(event));
  late final isValidPassword =
      _isValidPassword.map((event) => !event).toObs(false);

  /// 로그인 버튼 클릭.
  late final _isEnabledLogin = CombineLatestStream(
      [_isValidEmail, _isValidPassword],
      (values) => values.every((element) => element));
  late final isEnabledLogin = _isEnabledLogin.toObs(false);

  /// 간편 회원가입 클릭.
  void onPressedSimpleSignUp() {
    Get.toNamed(RouteType.TERM);
  }

  /// 아이디 찾기 클릭.
  void onPressedFindId() {
    Get.toNamed(RouteType.FIND_ID);
  }

  /// 비밀번호 찾기 클릭.
  void onPressedFindPw() {
    Get.toNamed(RouteType.FIND_PASSWORD);
  }

  /// 로그인 버튼 클릭.
  void onPressedLogin() {
    Get.offAllNamed(RouteType.HOME);
  }

  /// 네이버 클릭.
  void onPressedNaver() {
    showToast("네이버 로그인 클릭");
  }

  /// 카카오 클릭.
  void onPressedKakao() {
    showToast("카카오 로그인 클릭");
  }

  /// 애플 클릭.
  void onPressedApple() {
    showToast("애플 로그인 클릭");
  }

  @override
  void dispose() {
    email.close();
    super.dispose();
  }
}
