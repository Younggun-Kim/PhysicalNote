import 'package:physical_note/app/config/constant/app_constant.dart';
import 'package:physical_note/app/data/naver/model/naver_access_token_fail_model.dart';
import 'package:physical_note/app/data/naver/model/naver_access_token_success_model.dart';
import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/utils/utils.dart';

class NaverAPI extends API {
  NaverAPI() : super(basePath: "");

  Future<dynamic> accessToken({required String code}) async {
    var url = "https://nid.naver.com/oauth2.0/token";

    url += "?grant_type=authorization_code";
    url += "&client_id=${AppConstant.naverClientId}";
    url += "&client_secret=${AppConstant.naverClientSecret}";
    url += "&redirect_uri=${AppConstant.naverRedirectUrl}";
    url += "&code=$code";

    logger.i("Request Naver Token: $url");

    final response = await get(url);

    logger.i(response.bodyString);


    if(response.hasError) {
      return NaverAccessTokenFailModel.fromJson(response.body);
    } else {
      return NaverAccessTokenSuccessModel.fromJson(response.body);
    }
  }

  Future<void> getMe(String accessToken) async {
    const url = "https://openapi.naver.com/v1/nid/me";

    final response = await get(
      url,
      headers: {"Authorization": "Bearer $accessToken"},
    );

    logger.i(response.bodyString);

    return;
  }
}
