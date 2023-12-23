import 'package:physical_note/app/data/intensity/model/get_intensity_response_model.dart';
import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

class IntensityAPI extends API {
  IntensityAPI() : super(basePath: "/api/intensity");

  /// 운동 강도 조회
  Future<dynamic> getIntensity(String date) async {
    final response = await get("$requestUrl?recordDate=$date");

    logger.w(response.bodyString);

    if (response.status.hasError) {
      final failResponse = ServerResponseFailModel.fromJson(response.body);
      return failResponse;
    } else {
      /// 파싱하기 위해 data: [] 형식으로 만들어 줌
      final successResponse =
          GetIntensityListResponseModel.fromJson({"data": response.body});
      logger.i("Success Response: ${successResponse.toJson()}");
      return successResponse;
    }
  }
}
