import 'package:physical_note/app/data/login/model/post_login_request_model.dart';
import 'package:physical_note/app/data/login/model/post_login_response_model.dart';
import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';

import '../../utils/logger/logger.dart';

class LoginAPI extends API {
  LoginAPI() : super(basePath: "/login");

  /// 로그인 요청.
  Future<PostLoginResponseModel?> postLogin(
      PostLoginRequestModel requestData) async {
    // logger.i("PostLoginRequestModel : $requestData");

    final response = await post(
      requestUrl,
      requestData.toJson(),
    );

    if (response.status.hasError) {
      final failResponse = ServerResponseFailModel.fromJson(response.body);
      logger.i("Fail Message: ${failResponse.toJson()}");
      return Future.error({failResponse.message});
    } else {
      final successResponse = PostLoginResponseModel.fromJson(response.body);
      logger.i("Success Response: ${successResponse.toJson()}");
      return successResponse;
    }
  }
}
