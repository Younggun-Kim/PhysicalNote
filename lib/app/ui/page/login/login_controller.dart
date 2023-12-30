import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/user_type.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/login/model/post_login_request_model.dart';
import 'package:physical_note/app/data/login/model/post_login_response_model.dart';
import 'package:physical_note/app/data/login/model/post_pass_request_model.dart';
import 'package:physical_note/app/data/login/model/post_pass_response_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/user/user_storage.dart';
import 'package:physical_note/app/ui/page/find_id/find_id_args.dart';
import 'package:physical_note/app/ui/page/find_password/find_password_args.dart';
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
    Get.toNamed(RouteType.TERM);
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
    logger.i("카카오 로그인 클릭");
  }

  /// 애플 클릭.
  void onPressedApple() {
    logger.i("애플 로그인 클릭");
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
      token = response.token;
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
    await FlutterNaverLogin.logOutAndDeleteToken();
    await FlutterNaverLogin.logIn();
    final accessToken = await FlutterNaverLogin.currentAccessToken;

    logger.i("Naver Access Token : $accessToken");

    if (accessToken.accessToken.isEmpty) {
      logger.i("네이버 액세스 토큰이 없습니다.");
      return;
    }

    final token = await _postLogin(
      snsType: UserSnsType.naver,
      id: null,
      password: accessToken.accessToken,
    );

    if (token == null) {
      /// 약관 동의로 이동.
      /// 이때 accessToken 넘겨주기?
      /// snsType만 넘겨주고 나머지 프로세스는 알아서 하도록 할까?
    } else {
      /// 정보 저장 후 로그인 하기.
      _login(token, UserSnsType.naver);
    }
  }

  /// 카카오 로그인.
  void _kakaoLogin() async {

  }

  /// 로그인 성공.
  void _login(String token, UserSnsType snsType) {
    final userStorage = UserStorage();
    userStorage.snsType.val = snsType.toString();
    userStorage.apiKey.val = token;
    Get.offAllNamed(RouteType.MAIN);
  }
}
