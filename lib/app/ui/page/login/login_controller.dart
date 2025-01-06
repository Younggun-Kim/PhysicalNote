import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/sns_type.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/login/model/post_login_request_model.dart';
import 'package:physical_note/app/data/user/user_storage.dart';
import 'package:physical_note/app/ui/page/term/term_args.dart';
import 'package:physical_note/app/utils/sns/apple_login.dart';
import 'package:physical_note/app/utils/sns/kakao_login.dart';
import 'package:physical_note/app/utils/sns/login_process.dart';
import 'package:physical_note/app/utils/sns/naver_login.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';


class LoginController extends BaseController {
  final LoginAPI api;

  LoginController({required this.api});

  @override
  void onInit() {
    super.onInit();

    // 로그인
    final userStorage = UserStorage();
    userStorage.removeFilter();
  }

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
    final args = TermArgs(snsType: UserSnsType.idPw, accessToken: "");
    Get.toNamed(RouteType.TERM, arguments: args);
  }

  /// 아이디 찾기 클릭.
  Future onPressedFindId() async {
    Get.toNamed(RouteType.FIND_ID);
  }

  /// 비밀번호 찾기 클릭.
  void onPressedFindPw() async {
    Get.toNamed(RouteType.FIND_PASSWORD);
  }

  /// 로그인 버튼 클릭.
  Future<void> onPressedLogin() async {
    try {
      final loginProcess = Get.find<LoginProcess>();
      setLoading(true);
      final requestData = PostLoginRequestModel(
        loginId: email.value,
        password: password.value,
        type: UserSnsType.idPw.toString(),
      );

      final moveType = await loginProcess.loginAndMove(requestData: requestData);

      loginProcess.movePage(moveType);
    } catch(e) {
      logger.e(e);
    } finally {

      setLoading(false);
    }
  }

  /// 네이버 클릭.
  void onPressedNaver() {
    _naverLogin();
  }

  /// 카카오 클릭.
  void onPressedKakao() {
    _kakaoLogin();
  }

  /// 애플 클릭.
  void onPressedApple() {
    _appleLogin();
  }

  @override
  void dispose() {
    email.close();
    super.dispose();
  }

  /// 네이버 로그인
  void _naverLogin() async {
    final naverLogin = Get.find<NaverLogin>();
    final accessToken = await naverLogin.login();

    if (accessToken == null || accessToken.isEmpty) {
      logger.i("네이버 액세스 토큰이 없습니다.");
      return;
    }

    setLoading(true);
    final loginProcess = Get.find<LoginProcess>();

    final moveType = await loginProcess.loginAndMove(
        requestData: PostLoginRequestModel(
      loginId: null,
      password: accessToken,
      type: UserSnsType.naver.toString(),
    ));

    final termArgs =
        TermArgs(snsType: UserSnsType.naver, accessToken: accessToken);
    loginProcess.movePage(moveType, args: termArgs);
    setLoading(false);
  }

  /// 카카오 로그인.
  void _kakaoLogin() async {
    final kakaoLogin = Get.find<KakaoLogin>();
    final accessToken = await kakaoLogin.login();

    if (accessToken == null) {
      logger.e("카카오 액세스 토큰이 없습니다.");
      return;
    }

    setLoading(true);
    final loginProcess = Get.find<LoginProcess>();

    final moveType = await loginProcess.loginAndMove(
        requestData: PostLoginRequestModel(
      loginId: null,
      password: accessToken,
      type: UserSnsType.kakao.toString(),
    ));

    final termArgs =
        TermArgs(snsType: UserSnsType.kakao, accessToken: accessToken);
    loginProcess.movePage(moveType, args: termArgs);
    setLoading(false);
  }

  /// 애플 로그인.
  void _appleLogin() async {
    final appleLogin = Get.find<AppleLogin>();
    final appleResult = await appleLogin.login();

    if (appleResult == null) {
      logger.e("애플 로그인 실패.");
      return null;
    }

    setLoading(true);

    final loginRequestData = PostLoginRequestModel(
      loginId: appleResult.id,
      password: appleResult.token,
      type: UserSnsType.apple.toString(),
    );

    final loginProcess = Get.find<LoginProcess>();

    final moveType = await loginProcess.loginAndMove(
      requestData: loginRequestData,
    );

    logger.i('moveType: ${moveType?.name}');

    loginProcess.movePage(moveType);
    setLoading(false);
  }
}
