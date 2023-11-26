import 'package:physical_note/app/data/network/model/base_list_model%20/base_list_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/workout/model/get_workout_category_response_list_item_model.dart';

import '../../utils/logger/logger.dart';
import '../network/api.dart';

/// 운동 API.
class WorkoutAPI extends API {
  WorkoutAPI() : super(basePath: "/api/workout");

  /// 운동 카테고리 목록 조회.
  Future<BaseListModel<GetWorkoutCategoryResponseListItemModel>>
      getWorkoutCategory(int page) async {
    final response = await get(
      requestUrl + "/category?page=$page",
    );

    logger.i("Success Response: ${response.bodyString}");

    if (response.status.hasError) {
      final failResponse = ServerResponseFailModel.fromJson(response.body);
      logger.i("Fail Message: ${failResponse.toJson()}");
      return Future.error({failResponse.message});
    } else {
      final successResponse =
          BaseListModel<GetWorkoutCategoryResponseListItemModel>.fromJson(
              response.body);
      logger.i("Success Response: ${successResponse.toJson()}");
      return successResponse;
    }
  }
}
