import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/user_type.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/login/model/post_login_request_model.dart';
import 'package:physical_note/app/data/login/model/post_login_response_model.dart';
import 'package:physical_note/app/data/login/model/post_login_sign_in_request_model.dart';
import 'package:physical_note/app/data/login/model/post_login_sign_in_response_model.dart';
import 'package:physical_note/app/data/login/model/post_pass_request_model.dart';
import 'package:physical_note/app/data/login/model/post_pass_response_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/user/user_storage.dart';
import 'package:physical_note/app/ui/page/find_id/find_id_args.dart';
import 'package:physical_note/app/ui/page/find_password/find_password_args.dart';
import 'package:physical_note/app/ui/page/term/term_args.dart';
import 'package:physical_note/app/utils/sns/apple_login.dart';
import 'package:physical_note/app/utils/sns/kakao_login.dart';
import 'package:physical_note/app/utils/sns/naver_login.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import 'login_pass_model.dart';

class LoginController extends BaseController {
  final LoginAPI api;

  LoginController({required this.api});

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
    final data = await _pass();
    if (data == null) {
      return;
    }

    final name = data.response.passInfo?.utf8_name;
    final phone = data.response.passInfo?.mobileno;

    if (name == null || phone == null) {
      return;
    }

    final args = FindIdArgs(
      name: name,
      phone: phone,
      passToken: data.passToken,
    );

    Get.toNamed(RouteType.FIND_ID, arguments: args);
  }

  /// 비밀번호 찾기 클릭.
  void onPressedFindPw() {
    Get.toNamed(
      RouteType.FIND_PASSWORD,
      arguments: FindPasswordArgs(
        name: null,
        email: null,
      ),
    );
  }

  /// 로그인 버튼 클릭.
  Future<void> onPressedLogin() async {
    final token = await _postLogin(
        snsType: UserSnsType.idPw, id: email.value, password: password.value);

    if (token == null) {
    } else {
      /// 정보 저장 후 로그인 하기.
      final userStorage = UserStorage();
      userStorage.apiKey.val = token;
      userStorage.snsType.val = UserSnsType.idPw.toString();
      Get.offAllNamed(RouteType.MAIN);
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

  /// API: 로그인 요청
  Future<String?> _postLogin({
    required UserSnsType snsType,
    required String? id,
    required String password,
  }) async {
    setLoading(true);
    final requestData = PostLoginRequestModel(
      loginId: id,
      password: password,
      type: snsType.toString(),
    );

    final response = await api.postLogin(requestData);
    String? token;

    if (response is PostLoginResponseModel) {
      token = response.token ?? "";
    } else {
      final message =
          (response as ServerResponseFailModel?)?.devMessage ?? "서버 에러";
      showToast(message);
    }

    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);

    return token;
  }

  /// 패스 정보 조회
  Future<LoginPassModel?> _pass() async {
    final passToken = await Get.toNamed(RouteType.PASS) as String?;

    if (passToken == null) {
      return null;
    }

    setLoading(true);
    final loginApi = Get.find<LoginAPI>();
    final requestData = PostPassRequestModel(
      code: passToken,
      loginType: UserSnsType.idPw.name,
    );
    final response = await loginApi.postLoginPass(requestData);
    if (response is PostPassResponseModel) {
      setLoading(false);
      return LoginPassModel(
        passToken: passToken,
        response: response,
      );
    } else {
      final message =
          (response as ServerResponseFailModel?)?.devMessage ?? "서버 에러";
      showToast(message);
      setLoading(false);
      return null;
    }
  }

  /// 네이버 로그인
  void _naverLogin() async {
    final naverLogin = Get.find<NaverLogin>();
    final accessToken = await naverLogin.login();

    if (accessToken == null || accessToken.isEmpty) {
      logger.i("네이버 액세스 토큰이 없습니다.");
      return;
    }

    final apiToken = await _postLogin(
      snsType: UserSnsType.naver,
      id: null,
      password: accessToken,
    );

    if (apiToken == null) {
      return;
    }

    _login(
      apiToken: apiToken,
      accessToken: accessToken,
      snsType: UserSnsType.naver,
      loginId: "",
    );
  }

  /// 카카오 로그인.
  void _kakaoLogin() async {
    final kakaoLogin = Get.find<KakaoLogin>();
    final accessToken = await kakaoLogin.login();
    if (accessToken == null) {
      logger.e("카카오 액세스 토큰이 없습니다.");
      return;
    }

    final apiToken = await _postLogin(
      snsType: UserSnsType.kakao,
      id: null,
      password: accessToken,
    );

    if (apiToken == null) {
      return;
    }

    _login(
      apiToken: apiToken,
      accessToken: accessToken,
      snsType: UserSnsType.kakao,
      loginId: "",
    );
  }

  /// 애플 로그인.
  void _appleLogin() async {
    final appleLogin = Get.find<AppleLogin>();
    final appleResult = await appleLogin.login();

    if (appleResult == null) {
      logger.e("애플 로그인 실패.");
      return null;
    }

    final apiToken = await _postLogin(
      snsType: UserSnsType.apple,
      id: appleResult.id,
      password: appleResult.token,
    );

    if (apiToken == null) {
      logger.e("로그인 실패");
      return;
    }

    _login(
        apiToken: apiToken,
        accessToken: appleResult.token,
        snsType: UserSnsType.apple,
        loginId: appleResult.id);
  }

  /// 로그인 성공.
  void _login({
    required String? apiToken,
    required String accessToken,
    required UserSnsType snsType,
    required String loginId,
  }) {
    final token = apiToken;
    if (token == null || token.isEmpty) {
      /// 약관 이동.
      if (snsType == UserSnsType.kakao || snsType == UserSnsType.naver) {
        final termArgs = TermArgs(snsType: snsType, accessToken: accessToken);
        Get.toNamed(RouteType.TERM, arguments: termArgs);
      } else if (snsType == UserSnsType.apple) {
        /// 애플 회원가입 처리.
        /// 애플 회원가입 시 PassToken null.
        _appleSignIn(loginId, accessToken);
      }
    } else {
      final userStorage = UserStorage();
      userStorage.snsType.val = snsType.toString();
      userStorage.apiKey.val = token;
      Get.offAllNamed(RouteType.MAIN);
    }
  }

  /// API - 회원가입.
  Future<void> _appleSignIn(String id, String password) async {
    setLoading(true);
    final loginApi = Get.find<LoginAPI>();
    final requestData = PostLoginSignInRequestModel(
      loginId: id,
      passCode: null,
      password: password,
      type: UserSnsType.apple.toString(),
    );
    final response = await loginApi.postLoginSignIn(requestData: requestData);

    if (response is PostLoginSignInResponseModel) {
      final token = response.token;
      if (response.status == false || token == null) {
        showToast(response.message ?? "서버 에러");
      } else {
        // 토큰 저장 후 홈으로 이동.
        final userStorage = UserStorage();
        userStorage.apiKey.val = token;
        userStorage.snsType.val = UserSnsType.apple.toString();
        Get.offAllNamed(RouteType.MAIN);
      }
    } else {
      final message =
          (response as ServerResponseFailModel?)?.devMessage ?? "서버 에러";
      showToast(message);
    }

    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);
  }
}
