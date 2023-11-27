import 'package:physical_note/app/data/network/model/base_list_model/paginate_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';

import '../../utils/logger/logger.dart';
import '../network/api.dart';
import 'model/get_workout_category_response_list_item_model.dart';

/// 운동 API.
class WorkoutAPI extends API {
  WorkoutAPI() : super(basePath: "/api/workout");

  /// 운동 카테고리 목록 조회.
  Future<PaginateModel> getWorkoutCategory(int page) async {
    final response = await get(
      requestUrl + "/category?page=$page",
    );

    logger.i("API Response: ${response.bodyString}");

    if (response.status.hasError) {
      final failResponse = ServerResponseFailModel.fromJson(response.body);
      return Future.error({failResponse.message});
    } else {
      final successResponse = PaginateModel.fromJson(response.body, GetWorkoutCategoryResponseListItemModel.fromJson);
      return successResponse;
    }
  }
}
