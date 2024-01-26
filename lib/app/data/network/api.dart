import 'package:get/get.dart';
import 'package:physical_note/app/data/user/user_storage.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

class API extends GetConnect {
  /// 서버 주소.
  final server = 'https://dev.hajinj.com';

  /// 기본 Path.
  final String basePath;

  get requestUrl => server + basePath;

  API({
    required this.basePath,
  });

  @override
  void onInit() {
    super.onInit();

    httpClient
      ..defaultContentType = 'application/json'
      ..timeout = const Duration(seconds: 10)
      ..addRequestModifier<dynamic>(
        (request) {
          /// 헤더에 토큰 추가 작업
          logger.i('Request Url: ${request.url.toString()}');
          if (request.url.toString().contains("/api")) {
            final userStorage = UserStorage();
            final token = userStorage.apiKey.val;
            request.headers['Authorization'] = 'bearer $token';
          } else {
            request.headers.remove('Authorization');
          }
          logger.w("Request Header: ${request.headers.toString()}");
          return request;
        },
      );
  }
}
