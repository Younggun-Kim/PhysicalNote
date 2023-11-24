import 'package:physical_note/app/data/login/model/post_login_request_model.dart';
import 'package:physical_note/app/data/login/model/post_login_response_model.dart';
import 'package:physical_note/app/data/network/api.dart';

import '../../utils/logger/logger.dart';

class LoginAPI extends API {
  LoginAPI() : super(basePath: "/login");

  /// 로그인 요청.
  Future<PostLoginResponseModel?> postLogin(
      PostLoginRequestModel requestData) async {
    logger.i("requestUrl : $requestUrl");
    final response = await post(requestUrl, requestData.toJson());

    logger.i("PostLoginResponseModel : ${response}");

    if (response.status.hasError) {
      return null;
    } else {
      return response.body as PostLoginResponseModel;
    }
  }
}
