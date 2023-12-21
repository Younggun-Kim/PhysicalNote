import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/wellness/model/post_wellness_request_model.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'model/get_wellness_response_model.dart';

class WellnessAPI extends API {
  WellnessAPI() : super(basePath: "/api/welllness");

  Future<GetWellnessResponseModel?> getWellness(String date) async {
    final response = await get("$requestUrl?recordDate=$date");

    logger.w(response.bodyString);

    if (response.status.hasError) {
      return null;
    } else {
      final successResponse = GetWellnessResponseModel.fromJson(response.body);
      logger.i("Success Response: ${successResponse.toJson()}");
      return successResponse;
    }
  }

  /// 유저 정보 등록/수정.
  Future<GetWellnessResponseModel?> postWellness(
      {required PostWellnessRequestModel requestData}) async {
    logger.i("postWellness: ${requestData.toJson()}");
    final response = await post(requestUrl, requestData.toJson());

    logger.w(response.bodyString);

    if (response.status.hasError) {
      return null;
    } else {
      final successResponse = GetWellnessResponseModel.fromJson(response.body);
      return successResponse;
    }
  }
}