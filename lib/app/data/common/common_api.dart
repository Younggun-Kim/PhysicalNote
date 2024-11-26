import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/photo_model.dart';
import 'package:physical_note/app/config/constant/term_type.dart';
import 'package:physical_note/app/data/common/model/post_upload_response_model.dart';
import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'model/get_term_response_model.dart';
import 'model/message_response_model.dart';

class CommonAPI extends API {
  CommonAPI() : super(basePath: "");

  /// 이미지 업로드
  Future<dynamic> postUpload(String dir, PhotoModel photoModel) async {
    final formData = FormData({
      'file': MultipartFile(photoModel.file?.path, filename: 'profile.jpg')
    });

    final response = await post(
      requestUrl + "/api/upload/$dir",
      formData,
    );

    if (response.status.hasError) {
      return ServerResponseFailModel.fromJson(response.body);
    } else {
      return PostUploadResponseModel.fromJson(response.body);
    }
  }

  /// 약관 조회.
  Future<dynamic> getTerms({
    required TermType type,
  }) async {
    try {
      final response = await get(
        requestUrl + "/terms/${type.toString()}",
      );

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        return GetTermResponseModel.fromJson(response.body);
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  /// 문자 인증 요청
  Future<dynamic> postAuthPhoneSend({required String phone}) async {
    logger.i("postAuthPhoneSend: $phone");
    try {
      final response = await post(requestUrl + "/auth/phone/send?phoneNumber=$phone", {});

      if (response.status.hasError) {
        return ServerResponseFailModel.fromJson(response.body);
      } else {
        return MessageResponseModel.fromJson(response.body);
      }
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
