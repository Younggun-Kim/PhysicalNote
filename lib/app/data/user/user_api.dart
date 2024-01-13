import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/user/model/get_user_response_model.dart';

import '../../utils/logger/logger.dart';
import 'model/post_user_request_model.dart';

class UserAPI extends API {
  UserAPI() : super(basePath: "/api/user");

  /// 로그인 요청.
  // TODO: API 수정 - positionId 필요, 팀 정보 필요.
  Future<dynamic> getUser() async {
    final response = await get(requestUrl);

    logger.w(response.bodyString);

    if (response.status.hasError) {
      return ServerResponseFailModel.fromJson(response.body);
    } else {
      return GetUserResponseModel.fromJson(response.body);
    }
  }

  /// 유저 정보 등록/수정.
  // TODO: API 확인 필요, PassVerify 확인 필요,, Passcode를 보내긴 해야한느데 - 애플일 때 보냄.
  /// 프로필 url 이상함
  Future<dynamic> postUser({required PostUserRequestModel requestData}) async {
    try {
      logger.i("postUser: ${requestData.toJson()}");

      final response = await post(requestUrl, requestData.toJson());

      logger.w(response.bodyString);

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        return GetUserResponseModel.fromJson(response.body);
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
