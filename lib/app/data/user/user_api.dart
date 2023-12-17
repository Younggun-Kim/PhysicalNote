import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/user/model/get_user_response_model.dart';

import '../../utils/logger/logger.dart';
import 'model/post_user_request_model.dart';

class UserAPI extends API {
  UserAPI() : super(basePath: "/api/user");

  /// 로그인 요청.
  // TODO: API 수정 - positionId 필요, 팀 정보 필요.
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

  /// 유저 정보 등록/수정.
  // TODO: API 확인 필요.
  Future<GetUserResponseModel?> postUser(
      {required PostUserRequestModel requestData}) async {
    logger.i("request UserAPI.postUser: ${requestData.toJson()}");
    final response = await post(requestUrl, requestData);

    logger.w(response.bodyString);

    if (response.status.hasError) {
      return null;
    } else {
      final successResponse = GetUserResponseModel.fromJson(response.body);
      logger.i("Success Response: ${successResponse.toJson()}");
      return successResponse;
    }
  }
}
