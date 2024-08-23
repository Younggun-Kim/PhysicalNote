import 'package:physical_note/app/data/login/model/post_check_id_response_model.dart';
import 'package:physical_note/app/data/login/model/post_login_find_id_response_model.dart';
import 'package:physical_note/app/data/login/model/post_login_relogin_response_model.dart';
import 'package:physical_note/app/data/login/model/post_login_request_model.dart';
import 'package:physical_note/app/data/login/model/post_login_response_model.dart';
import 'package:physical_note/app/data/login/model/post_login_sign_in_request_model.dart';
import 'package:physical_note/app/data/login/model/post_login_sign_in_response_model.dart';
import 'package:physical_note/app/data/login/model/post_phone_authentication_response_model.dart';
import 'package:physical_note/app/data/network/api.dart';

import '../../utils/logger/logger.dart';
import '../network/model/server_response_fail/server_response_fail_model.dart';
import 'model/post_change_password_response_model.dart';
import 'model/post_pass_request_model.dart';
import 'model/post_pass_response_model.dart';

class LoginAPI extends API {
  LoginAPI() : super(basePath: "/login");

  /// 로그인 요청.
  Future<dynamic> postLogin(PostLoginRequestModel requestData) async {
    logger.w("postLogin: ${requestData.toJson()}");

    final response = await post(
      requestUrl,
      requestData.toJson(),
    );


    if (response.status.hasError) {
      return ServerResponseFailModel.fromJson(response.body);
    } else {
      return PostLoginResponseModel.fromJson(response.body);
    }
  }

  /// 리로그인 요청.
  Future<dynamic> postLoginRelogin() async {
    try {
      final fullUrl = "$server/api/login/relogin";
      final response = await post(fullUrl, {});

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        return PostLoginReloginResponseModel.fromJson(response.body);
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  /// 회원가입 요청.
  Future<dynamic> postLoginSignIn(
      {required PostLoginSignInRequestModel requestData}) async {
    try {
      logger.i("postLoginSignIn: ${requestData.toJson()}");
      final response = await post(
        requestUrl + "/signin",
        requestData.toJson(),
      );

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        return PostLoginSignInResponseModel.fromJson(response.body);
      }
    } catch (e) {
      logger.e(e);
    }
  }

  /// 아이디 찾기.
  Future<dynamic> postLoginFindId({
    required String authCode,
    required String phone,
  }) async {
    final response = await post(
      requestUrl + "/find_id",
      {"authCode": authCode, "phoneNumber": phone},
    );
    logger.i("postLoginFindId: authCode: $authCode, phoneNumber: $phone}");

    if (response.status.hasError) {
      return ServerResponseFailModel.fromJson(response.body);
    } else {
      return PostLoginFindIdResponseModel.fromJson(response.body);
    }
  }

  /// 비밀번호 찾기.
  Future<dynamic> postLoginFindPwStep1({required String code}) async {
    final response = await post(
      requestUrl + "/find_pw/step1",
      {"code": code},
    );

    if (response.status.hasError) {
      return ServerResponseFailModel.fromJson(response.body);
    } else {
      return PostLoginFindIdResponseModel.fromJson(response.body);
    }
  }

  /// 비밀번호 변경.
  Future<dynamic> postLoginFindPwStep2({
    required String password,
    required String email,
  }) async {
    final response = await post(
      requestUrl + "/find_pw/step2",
      {
        "password": password,
        "userLoginId": email,
      },
    );

    if (response.status.hasError) {
      return ServerResponseFailModel.fromJson(response.body);
    } else {
      return PostChangePasswordResponseModel.fromJson(response.body);
    }
  }

  /// Pass 정보 확인.
  Future<dynamic> postLoginPass(PostPassRequestModel requestData) async {
    final response = await post(
      requestUrl + "/pass",
      {"code": requestData.code},
    );

    logger.i(response.bodyString);

    if (response.status.hasError) {
      return ServerResponseFailModel.fromJson(response.body);
    } else {
      return PostPassResponseModel.fromJson(response.body);
    }
  }

  /// 아이디 중복 확인.
  Future<dynamic> postLoginSignInCheckId({required String loginId}) async {
    logger.i("postLoginSignInCheckId: $loginId");
    try {
      final response = await post(
        requestUrl + "/signin/check_id",
        {
          "loginId": loginId,
        },
      );

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        return PostCheckIdResponseModel.fromJson(response.body);
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  /// 문자 인증 요청
  Future<dynamic> postPhoneAuthentication({required String phone}) async {
    logger.i("postPhoneAuthentication: $phone");
    try {
      final response = await post(
        requestUrl + "/phone/authentication",
        {
          "phoneNo": phone,
        },
      );

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        return PostPhoneAuthenticationResponseModel.fromJson(response.body);
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  /// 비밀번호 찾기.
  Future<dynamic> postFindPwStep1({
    required String authCode,
    required String phone,
  }) async {
    final response = await post(
      requestUrl + "/find_pw/step1",
      {"authCode": authCode, "phoneNumber": phone},
    );

    if (response.status.hasError) {
      return ServerResponseFailModel.fromJson(response.body);
    } else {
      return PostLoginFindIdResponseModel.fromJson(response.body);
    }
  }
}
