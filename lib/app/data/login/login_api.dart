import 'package:physical_note/app/data/login/model/post_login_relogin_response_model.dart';
import 'package:physical_note/app/data/login/model/post_login_request_model.dart';
import 'package:physical_note/app/data/login/model/post_login_response_model.dart';
import 'package:physical_note/app/data/network/api.dart';

import '../../utils/logger/logger.dart';

class LoginAPI extends API {
  LoginAPI() : super(basePath: "/login");

  /// 로그인 요청.
  Future<PostLoginResponseModel?> postLogin(
      PostLoginRequestModel requestData) async {
    final response = await post(
      requestUrl,
      requestData.toJson(),
    );

    if (response.status.hasError) {
      return null;
    } else {
      final successResponse = PostLoginResponseModel.fromJson(response.body);
      logger.i("Success Response: ${successResponse.toJson()}");
      return successResponse;
    }
  }

  /// 리로그인 요청.
  Future<PostLoginReloginResponseModel?> postLoginRelogin() async {
    final fullUrl = "$server/api/login/relogin";
    final response = await post(fullUrl, {});

    if (response.status.hasError) {
      return null;
    } else {
      final successResponse =
          PostLoginReloginResponseModel.fromJson(response.body);
      logger.i("Success Response: ${successResponse.toJson()}");
      return successResponse;
    }
  }
}
