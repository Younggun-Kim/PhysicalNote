import 'dart:developer';

import 'package:physical_note/app/data/home/model/get_home_response_model.dart';
import 'package:physical_note/app/utils/utils.dart';

import '../network/api.dart';
import '../network/model/server_response_fail/server_response_fail_model.dart';

class HomeAPI extends API {
  HomeAPI() : super(basePath: "/api/home");

  /// 홈 조회.
  /// - parameters
  ///    - String recordDate - 일정 날짜.
  Future<dynamic> getHome(String recordDate) async {
    try {
      final response = await get(requestUrl + "?recordDate=$recordDate");

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        return GetHomeResponseModel.fromJson(response.body);
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
