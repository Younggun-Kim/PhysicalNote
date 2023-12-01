import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/data/network/model/base_list_model/paginate_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'model/teams_response_model.dart';

/// 팀 API.
class TeamsAPI extends API {
  TeamsAPI() : super(basePath: "/api/teams");

  /// 팀 목록 조회 API.
  // TODO: 키워드 추가.
  Future<PaginateModel> getTeams({required int page}) async {
    logger.w(requestUrl);
    final response = await get(
      requestUrl + "?page=$page",
    );

    logger.i("API Response: ${response.bodyString}");

    if (response.status.hasError) {
      final failResponse = ServerResponseFailModel.fromJson(response.body);
      return Future.error({failResponse.message});
    } else {
      final successResponse =
          PaginateModel.fromJson(response.body, TeamsResponseModel.fromJson);
      return successResponse;
    }
  }
}
