import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/photo_model.dart';
import 'package:physical_note/app/config/constant/term_type.dart';
import 'package:physical_note/app/data/common/model/post_upload_response_model.dart';
import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'model/get_term_response_model.dart';

class CommonAPI extends API {
  CommonAPI() : super(basePath: "");

  /// 이미지 업로드
  Future<PostUploadResponseModel?> postUpload(
      String dir, PhotoModel photoModel) async {
    final formData = FormData({
      'file': MultipartFile(photoModel.file?.path, filename: 'profile.jpg')
    });

    final response = await post(
      requestUrl + "/api/upload/$dir",
      formData,
    );

    logger.w(response.bodyString);

    if (response.status.hasError) {
      return null;
    } else {
      final successResponse = PostUploadResponseModel.fromJson(response.body);
      logger.i("Success Response: ${successResponse.toJson()}");
      return successResponse;
    }
  }

  /// 약관 조회.
  Future<dynamic> getTerms({
    required TermType type,
  }) async {
    final response = await get(
      requestUrl + "/terms/${type.toString()}",
    );

    logger.w(response.bodyString);

    if (response.status.hasError) {
      return ServerResponseFailModel.fromJson(response.body);
    } else {
      return GetTermResponseModel.fromJson(response.body);
    }
  }
}
