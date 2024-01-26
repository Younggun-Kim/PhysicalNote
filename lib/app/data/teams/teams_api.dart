import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/data/network/model/base_list_model/paginate_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'model/teams_response_model.dart';

/// 팀 API.
class TeamsAPI extends API {
  TeamsAPI() : super(basePath: "/api/teams");

  /// 팀 목록 조회 API.
  Future<dynamic> getTeams({required int page, String? keyword}) async {
    try {
      var url = requestUrl + "?page=$page";
      if (keyword != null) {
        url += "&name=$keyword";
      }
      final response = await get(
        url,
      );

      logger.i("${response.bodyString}");

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        return PaginateModel.fromJson(
            response.body, TeamsResponseModel.fromJson);
      }
    } catch (e) {
      logger.e(e);
    }
  }
}
