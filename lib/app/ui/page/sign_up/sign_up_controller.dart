import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class SignUpController extends BaseController {
  /// 이름.
  final name = "".obsWithController;

  /// 이름 유효성 검사.
  late final _isValidName =
      name.behaviorStream.map((event) => event.length > 2);
  late final isValidName = _isValidName.not().toObs(false);

  /// 이메일.
  final email = "".obsWithController;

  /// 이메일 유효성 검사.
  late final _isValidEmail = email.behaviorStream.map((event) => event.isEmail);
  late final isValidEmail = _isValidEmail.not().toObs(false);

  /// 전화번호.
  final phoneNumber = "".obsWithController;

  /// 전화번호 유효성 검사.
  late final _isValidPhoneNumber =
      phoneNumber.behaviorStream.map((event) => Regex.isPhoneNumber(event));
  late final isValidPhoneNumber = _isValidPhoneNumber.not().toObs(false);

  /// 비밀번호.
  final password = "".obsWithController;

  /// 비밀번호 확인.
  final passwordConfirm = "".obsWithController;

  /// 비밀번호 유효성 검사.
  late final _isValidPassword = CombineLatestStream(
    [
      password.behaviorStream,
      passwordConfirm.behaviorStream,
    ],
    (values) => Regex.isPassword(values[0]) && (values[0] == values[1]),
  );

  late final isValidPassword = _isValidPassword.not().toObs(false);

  /// 로그인 버튼 Enabled 여부
  late final isEnabledLoginButton = CombineLatestStream(
    [
      isValidName.behaviorStream,
      isValidEmail.behaviorStream,
      isValidPhoneNumber.behaviorStream,
      isValidPassword.behaviorStream,
    ],
    (values) {
      return values.every((element) => element == false);
    },
  ).toObs(false);

  /// 뒤로가기 클릭.
  void onPressedBackButton() {
    close();
  }

  /// 로그인 버튼 클릭.
  void onPressedLoginButton() {
    unFocus();
    Get.offAndToNamed(RouteType.LOGIN);
  }

  final onTapLoginButton = PublishSubject<void>()
    ..doOnData((event) {
      unFocus();
    }).listen(
      (event) => Get.until((route) => Get.currentRoute == RouteType.LOGIN),
    );
}
