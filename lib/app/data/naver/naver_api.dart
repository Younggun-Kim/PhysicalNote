import 'package:physical_note/app/data/network/api.dart';
import 'package:physical_note/app/utils/utils.dart';

class NaverAPI extends API {
  NaverAPI() : super(basePath: "");

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
