import 'package:physical_note/app/data/injury/model/get_injury_response_model.dart';
import 'package:physical_note/app/data/injury/model/post_injury_request_model.dart';
import 'package:physical_note/app/data/injury/model/post_injury_response_model.dart';
import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'model/delete_injury_response_model.dart';
import 'model/injury_response_model.dart';
import 'model/put_injury_detail_recovery_response_model.dart';

class InjuryAPI extends API {
  InjuryAPI() : super(basePath: "/api/injury");

  /// 부상 정보 조회.
  Future<dynamic> getInjury({
    required String recordDate,
    required bool recoveryYn,
  }) async {
    try {
      logger.i("getInjury: $recordDate");
      final response = await get(
        requestUrl + "?recordDate=$recordDate&recoveryYn=$recoveryYn",
      );

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        logger.i(response.body);
        return GetInjuryResponseModel.fromJson({"list": response.body});
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  /// 부상 상세 조회.
  Future<dynamic> getInjuryDetail({
    required int id,
  }) async {
    try {
      logger.i("getInjuryDetail: $id");
      final response = await get(
        requestUrl + "/$id",
      );

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        return InjuryResponseModel.fromJson(response.body);
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

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

  /// 부상 정보 수정.
  Future<dynamic> putInjury({
    required int injuryId,
    required PostInjuryRequestModel requestData,
  }) async {
    try {
      logger.i("putInjury: ${requestData.toJson()}");
      final response = await put(
        requestUrl + "/$injuryId",
        requestData.toJson(),
      );

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

  /// 부상 정보 삭제.
  Future<dynamic> deleteInjury({
    required int injuryId,
  }) async {
    try {
      logger.i("deleteInjury: $injuryId}");
      final response = await delete(
        requestUrl + "/$injuryId",
      );

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        return DeleteInjuryResponseModel.fromJson(response.body);
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  /// 부상 정보 수정.
  Future<dynamic> putInjuryDetailRecovery({
    required int userInjuryId,
  }) async {
    try {
      logger.i("putInjuryDetailRecovery: $userInjuryId");
      final response = await put(requestUrl + "/$userInjuryId/recovery", {});

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        return PutInjuryDetailRecoveryResponseModel.fromJson(response.body);
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
