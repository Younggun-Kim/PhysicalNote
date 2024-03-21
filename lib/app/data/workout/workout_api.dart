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
  Future<PaginateModel> getWorkoutCategory(
      {required int page, required String keyword}) async {
    final response =
        await get(requestUrl + "/category?page=$page&keyword=$keyword");

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
  Future<PaginateModel> getWorkoutDetail({
    required int pageKey,
    required int categoryId,
    required String keyword,
  }) async {
    final response = await get(
      requestUrl + "/$categoryId?page=$pageKey&keyword=$keyword",
    );

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
  Future<dynamic> getWorkoutPositionDetail({
    required int pageKey,
    required int workoutId,
    String? keyword,
  }) async {
    try {
      var apiUrl = "$requestUrl/position/$workoutId?page=$pageKey";

      if(keyword != null) {
        apiUrl += "&keyword=$keyword";
      }

      final response = await get(apiUrl);

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        return PaginateModel.fromJson(
            response.body, GetWorkoutPositionDetailResponseModel.fromJson);
      }
    } catch (e) {
      return null;
    }
  }
}
