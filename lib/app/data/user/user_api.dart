import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/user/model/get_user_response_model.dart';

import '../../utils/logger/logger.dart';
import 'model/delete_user_response_model.dart';
import 'model/post_user_request_model.dart';

class UserAPI extends API {
  UserAPI() : super(basePath: "/api/user");

  /// 로그인 요청.
  Future<dynamic> getUser() async {
    final response = await get(requestUrl);

    if (response.status.hasError) {
      return ServerResponseFailModel.fromJson(response.body);
    } else {
      return GetUserResponseModel.fromJson(response.body);
    }
  }

  /// 유저 정보 등록/수정.
  Future<dynamic> postUser({required PostUserRequestModel requestData}) async {
    try {
      logger.i("postUser: ${requestData.toJson()}");

      final response = await post(requestUrl, requestData.toJson());

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

  /// 탈퇴하기.
  Future<dynamic> deleteUser() async {
    try {
      final response = await delete(requestUrl + "/leave");

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        return DeleteUserResponseModel.fromJson(response.body);
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
