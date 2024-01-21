import 'dart:developer';

import 'package:physical_note/app/data/injury/model/post_injury_request_model.dart';
import 'package:physical_note/app/data/injury/model/post_injury_response_model.dart';
import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/utils/utils.dart';

class InjuryAPI extends API {
  InjuryAPI() : super(basePath: "/api/injury");

  /// 부상 정보 저장.
  Future<dynamic> postInjury({
    required PostInjuryRequestModel requestData,
  }) async {
    try {
      logger.i("postInjury: ${requestData.toJson()}");
      final response = await post(
        requestUrl,
        requestData.toJson(),
      );

      log(response.bodyString ?? "");

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        return PostInjuryResponseModel.fromJson(response.body);
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
