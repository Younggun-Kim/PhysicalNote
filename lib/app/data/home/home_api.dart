import 'package:physical_note/app/data/home/model/get_home_response_model.dart';
import 'package:physical_note/app/utils/utils.dart';

import '../network/api.dart';
import '../network/model/server_response_fail/server_response_fail_model.dart';

class HomeAPI extends API {
  HomeAPI() : super(basePath: "/api/home");

  /// 홈 조회.
  /// - parameters
  ///    - String recordDate - 일정 날짜.
  Future<GetHomeResponseModel> getHome(String recordDate) async {
    final response = await get(requestUrl + "?recordDate=$recordDate");

    logger.i("API Response: ${response.bodyString}");

    if (response.status.hasError) {
      final failResponse = ServerResponseFailModel.fromJson(response.body);
      return Future.error({failResponse.message});
    } else {
      final successResponse = GetHomeResponseModel.fromJson(response.body);
      return successResponse;
    }
  }
}
