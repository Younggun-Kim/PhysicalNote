import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/wellness/model/post_wellness_request_model.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'model/get_wellness_paginate_model.dart';
import 'model/get_wellness_response_model.dart';

class WellnessAPI extends API {
  WellnessAPI() : super(basePath: "/api/welllness");

  Future<dynamic> getWellness(String date) async {
    final response = await get("$requestUrl?recordDate=$date");

    if (response.status.hasError) {
      final failResponse = ServerResponseFailModel.fromJson(response.body);
      return failResponse;
    } else {
      final successResponse = GetWellnessResponseModel.fromJson(response.body);
      logger.i("Success Response: ${successResponse.toJson()}");
      return successResponse;
    }
  }

  /// 웰리니스 저장
  Future<dynamic> postWellness(
      {required PostWellnessRequestModel requestData}) async {
    logger.i("postWellness: ${requestData.toJson()}");
    final response = await post(requestUrl, requestData.toJson());

    if (response.status.hasError) {
      final failResponse = ServerResponseFailModel.fromJson(response.body);
      return failResponse;
    } else {
      final successResponse = GetWellnessResponseModel.fromJson(response.body);
      return successResponse;
    }
  }

  /// 웰리니스 수정
  Future<dynamic> putWellnessDetail({
    required int wellnessId,
    required PostWellnessRequestModel requestData,
  }) async {
    logger.i("putWellnessDetail: ${requestData.toJson()}");
    final response =
        await put(requestUrl + "/$wellnessId", requestData.toJson());

    if (response.status.hasError) {
      final failResponse = ServerResponseFailModel.fromJson(response.body);
      return failResponse;
    } else {
      final successResponse = GetWellnessResponseModel.fromJson(response.body);
      return successResponse;
    }
  }

  /// 웰리니스 목록 조회
  Future<dynamic> getWellnessList({
    required int page,
    required String period,
    required String sortDirection,
  }) async {
    logger.i(
        "getWellnessList: page: $page, peroid: $period, sortDirection: $sortDirection");
    final response = await get(
      '$requestUrl/list?page=$page&period=$period&sortDirection=$sortDirection',
    );

    if (response.status.hasError) {
      final failResponse = ServerResponseFailModel.fromJson(response.body);
      return failResponse;
    } else {
      final successResponse = GetWellnessPaginateModel.fromJson(response.body);

      return successResponse;
    }
  }
}
