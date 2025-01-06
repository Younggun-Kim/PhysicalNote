import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/sns_type.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/login/model/post_login_relogin_response_model.dart';
import 'package:physical_note/app/data/login/model/post_login_request_model.dart';
import 'package:physical_note/app/data/login/model/post_login_response_model.dart';
import 'package:physical_note/app/data/login/model/post_login_sign_in_request_model.dart';
import 'package:physical_note/app/data/login/model/post_login_sign_in_response_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/user/model/get_user_response_model.dart';
import 'package:physical_note/app/data/user/model/post_user_push_response_model.dart';
import 'package:physical_note/app/data/user/user_api.dart';
import 'package:physical_note/app/resources/strings/translations.dart';
import 'package:physical_note/app/ui/page/information_registration_guide/information_registration_guide_args.dart';

import '../../data/user/user_storage.dart';
import '../utils.dart';
import 'login_move_type.dart';

class LoginProcess {
  final LoginAPI loginApi;

  final UserAPI userApi;

  LoginProcess({
    required this.loginApi,
    required this.userApi,
  });

  /// 회원가입 & 화면이동.
  Future<LoginMoveType?> signInAndMove({
    required PostLoginSignInRequestModel requestData,
  }) async {
    final isLoginSuccess = await _signIn(requestData: requestData);

    if (isLoginSuccess) {
      return _getUserAndMove();
    } else {
      return null;
    }
  }

  /// 로그인 & 화면 이동.
  Future<LoginMoveType?> loginAndMove({
    required PostLoginRequestModel requestData,
  }) async {
    final isLoginSuccess = await _login(requestData: requestData);

    if (isLoginSuccess) {
      return await _getUserAndMove();
    } else {
      /// 약관 이동.
      if (requestData.type == UserSnsType.naver.toString() ||
          requestData.type == UserSnsType.kakao.toString()) {
        return LoginMoveType.term;
      } else if (requestData.type == UserSnsType.apple.toString()) {
        /// 애플 회원가입.
        return await signInAndMove(
          // TODO: 추후 SNS 추가시 변경 필요.
          requestData: PostLoginSignInRequestModel(
            loginId: requestData.loginId,
            passCode: null,
            password: requestData.password,
            type: requestData.type,
            name: '',
            cellphoneNo: '',
            birthDate: '',
            gender: '',
          ),
        );
      }
    }

    /// Email 로그인이면 동작 없음.
    return null;
  }

  /// 리로그인 & 화면 이동.
  Future<LoginMoveType?> reloginAndMove() async {
    final isLoginSuccess = await _relogin();

    if (isLoginSuccess) {
      return await _getUserAndMove();
    } else {
      return LoginMoveType.login;
    }
  }

  /// 로그인.
  Future<bool> _login({
    required PostLoginRequestModel requestData,
  }) async {
    final response = await loginApi.postLogin(requestData);

    logger.i(response);
    if (response is PostLoginResponseModel) {
      final apiToken = response.token;
      final snsType = requestData.type;

      if (apiToken != null) {
        _loginSuccess(apiToken, snsType);
        return true;
      }
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }

    return false;
  }

  /// 리로그인.
  Future<bool> _relogin() async {
    final response = await loginApi.postLoginRelogin();

    if (response is PostLoginReloginResponseModel) {
      _loginSuccess(response.token, null);
      return true;
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      logger.e(message);
    }

    return false;
  }

  /// 유저 정보 조회해서 페이지 이동.
  Future<LoginMoveType?> _getUserAndMove() async {
    /// 로그인

    final response = await userApi.getUser();
    if (response is GetUserResponseModel) {
      final workoutId = response.workoutId;
      final teamId = response.teamId;
      final teamRequest = response.teamRequestYn;

      /// 1. 정보등록 안내 화면  : workoudId = null
      /// 2. 팀 재등록 안내 화면  : workoutId != null && teamId = null && teamRequestYn = false
      /// 3. 승인요청중 안내 화면 :  : workoutId != null && teamId = null && teamRequestYn = true
      /// 4. 홈 화면 : workoutId != null && teamId != null && teamRequestYn = false
      if (workoutId == null) {
        return LoginMoveType.information;
      } else if (teamId == null && teamRequest == false) {
        return LoginMoveType.team;
      } else if (teamId == null && teamRequest == true) {
        return LoginMoveType.teamRequest;
      } else {
        return LoginMoveType.home;
      }
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }
    return null;
  }

  /// 회원가입 Api.
  Future<bool> _signIn({
    required PostLoginSignInRequestModel requestData,
  }) async {
    final response = await loginApi.postLoginSignIn(requestData: requestData);

    /// 가입 성공.
    if (response is PostLoginSignInResponseModel) {
      final apiToken = response.token;
      if (response.status == false || apiToken == null) {
        showToast(response.message ?? "서버 에러");
      } else {
        _loginSuccess(apiToken, requestData.type);
        return true;
      }
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }
    return false;
  }

  /// 로그인 성공 - 홈 이동.
  void _saveUserInfo(String apiToken, String? snsType) {
    final userStorage = UserStorage();
    userStorage.apiKey.val = apiToken;
    if (snsType != null) {
      userStorage.snsType.val = snsType;
    }
  }

  /// 로그인 성공.
  Future<void> _loginSuccess(String apiToken, String? snsType) async {
    _saveUserInfo(apiToken, snsType);
    await _postPushToken();
  }

  /// 페이지 이동.
  void movePage(LoginMoveType? moveType, {dynamic args}) {
    final type = moveType;
    if (type == null) {
      return;
    }
    switch (type) {
      case LoginMoveType.home:
        Get.offAllNamed(RouteType.MAIN);

      case LoginMoveType.information:
        final args = InformationRegistrationGuideArgs(hasWorkout: false);
        Get.offAllNamed(RouteType.INFORMATION_REGISTRATION_GUIDE,
            arguments: args);

      case LoginMoveType.team:
        final args = InformationRegistrationGuideArgs(hasWorkout: true);
        Get.offAllNamed(RouteType.INFORMATION_REGISTRATION_GUIDE,
            arguments: args);

      case LoginMoveType.teamRequest:
        Get.offAllNamed(RouteType.TEAM_REQUEST);

      case LoginMoveType.term:
        Get.toNamed(RouteType.TERM, arguments: args);

      case LoginMoveType.login:
        Get.offAllNamed(RouteType.LOGIN);
    }
  }

  /// Push 토큰 기록 API
  Future<void> _postPushToken() async {
    final token = await FirebaseMessaging.instance.getToken();

    if (token == null) {
      logger.e('Unexpected Error - FCM token null');
      return;
    }

    final response = await userApi.postUserPush(token: token);

    /// 가입 성공.
    if (response is PostUserPushResponseModel) {
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }
  }
}
