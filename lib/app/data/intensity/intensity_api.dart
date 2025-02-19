import 'package:physical_note/app/data/intensity/model/get_intensity_response_model.dart';
import 'package:physical_note/app/data/intensity/model/post_intensity_request_model.dart';
import 'package:physical_note/app/data/intensity/model/post_intensity_response_model.dart';
import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

import 'model/get_intensity_paginate_model.dart';

class IntensityAPI extends API {
  IntensityAPI() : super(basePath: "/api/intensity");

  /// 운동 강도 조회
  Future<dynamic> getIntensity(String date) async {
    try {
      final response = await get("$requestUrl?recordDate=$date");

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        /// 파싱하기 위해 data: [] 형식으로 만들어 줌
        return GetIntensityListResponseModel.fromJson({"data": response.body});
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  /// 운동 강도 저장.
  Future<dynamic> postIntensity(PostIntensityRequestModel requestData) async {
    logger.i("postIntensity: ${requestData.toJson()}");
    final response = await post(requestUrl, requestData.toJson());

    if (response.status.hasError) {
      final failResponse = ServerResponseFailModel.fromJson(response.body);
      return failResponse;
    } else {
      final successResponse =
          PostIntensityResponseModel.fromJson(response.body);
      return successResponse;
    }
  }

  /// 운동 강도 수정
  Future<dynamic> putIntensity(
      PostIntensityRequestModel requestData, int intensityId) async {
    logger.i("putIntensity: ${requestData.toJson()}");
    final response =
        await put("$requestUrl/$intensityId", requestData.toJson());

    if (response.status.hasError) {
      final failResponse = ServerResponseFailModel.fromJson(response.body);
      return failResponse;
    } else {
      final successResponse =
          PostIntensityResponseModel.fromJson(response.body);
      return successResponse;
    }
  }

  /// 운동 이력 조회
  Future<dynamic> getIntensityList({
    required int pageKey,
    required String period,
    required String sortDirection,
  }) async {
    try {
      final response = await get(
        "$requestUrl/list?page=$pageKey&period=$period&sortDirection=$sortDirection",
      );

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        return GetIntensityPaginateModel.fromJson(response.body);
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
