import 'package:physical_note/app/data/network/model/base_list_model/paginate_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/workout/model/get_workout_detail_response_list_item_model.dart';
import 'package:physical_note/app/data/workout/model/get_workout_position_detail_response_model.dart';

import '../../utils/logger/logger.dart';
import '../network/api.dart';
import 'model/get_workout_category_response_list_item_model.dart';

/// 운동 API.
class WorkoutAPI extends API {
  WorkoutAPI() : super(basePath: "/api/workout");

  /// 운동 카테고리 목록 조회.
  /// // TODO: API 수정 - 검색어 필요.
  Future<PaginateModel> getWorkoutCategory({
    required int page,
  }) async {
    final response = await get(
      requestUrl + "/category?page=$page",
    );

    logger.i("API Response: ${response.bodyString}");

    if (response.status.hasError) {
      final failResponse = ServerResponseFailModel.fromJson(response.body);
      return Future.error({failResponse.message});
    } else {
      final successResponse = PaginateModel.fromJson(
          response.body, GetWorkoutCategoryResponseListItemModel.fromJson);
      return successResponse;
    }
  }

  /// 운동 목록 조회.
  // TODO: API 수정 - 검색어 필요.
  Future<PaginateModel> getWorkoutDetail({
    required int pageKey,
    required int categoryId,
  }) async {
    final response = await get(
      requestUrl + "/$categoryId?page=$pageKey",
    );

    logger.i("API Response: ${response.bodyString}");

    if (response.status.hasError) {
      final failResponse = ServerResponseFailModel.fromJson(response.body);
      return Future.error({failResponse.message});
    } else {
      final successResponse = PaginateModel.fromJson(
          response.body, GetWorkoutDetailResponseItemModel.fromJson);

      return successResponse;
    }
  }

  /// 운동 포지션 조회.
  Future<PaginateModel> getWorkoutPositionDetail({
    required int pageKey,
    required int workoutId,
  }) async {
    final response = await get(
      requestUrl + "/position/$workoutId?page=$pageKey",
    );

    logger.i("API Response: ${response.bodyString}");

    if (response.status.hasError) {
      final failResponse = ServerResponseFailModel.fromJson(response.body);
      logger.i("Fail Message: ${failResponse.toJson()}");
      return Future.error({failResponse.message});
    } else {
      final successResponse = PaginateModel.fromJson(
          response.body, GetWorkoutPositionDetailResponseModel.fromJson);
      logger.i("successResponse: ${successResponse.toJson()}");
      return successResponse;
    }
  }
}
