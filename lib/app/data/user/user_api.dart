import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/user/model/get_user_response_model.dart';

import '../../utils/logger/logger.dart';

class UserAPI extends API {
  UserAPI() : super(basePath: "/api/user");

  /// 로그인 요청.
  Future<GetUserResponseModel?> getUser() async {
    logger.i("call UserAPI.getUser");
    final response = await get(requestUrl);
    
    logger.w(response.bodyString);

    if (response.status.hasError) {
      final failResponse = ServerResponseFailModel.fromJson(response.body);
      logger.i("Fail Message: ${failResponse.toJson()}");
      return Future.error({failResponse.message});
    } else {
      final successResponse = GetUserResponseModel.fromJson(response.body);
      logger.i("Success Response: ${successResponse.toJson()}");
      return successResponse;
    }
  }
}
