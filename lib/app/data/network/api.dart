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
          if (request.url.toString().contains("/api")) {
            final userStorage = UserStorage();
            final token = userStorage.apiKey.val;
            request.headers['Authorization'] = 'bearer $token';
          } else {
            request.headers.remove('Authorization');
          }
          final logMessage = [
            'Request Header: ${request.headers.toString()}',
            'Request Url: [${request.method.toUpperCase()}]${request.url.toString()}',
          ].join('\n');

          logger.i(logMessage);
          return request;
        },
      )
      ..addResponseModifier((request, response) {
        final requestMethodUrl =
            "[${request.method.toUpperCase()}]${request.url}";
        final statusCode = "Status Code : ${response.statusCode}";
        final logMessage = [
          requestMethodUrl,
          statusCode,
          response.bodyString,
        ].join("\n");
        logger.i(logMessage);

        return response;
      });
  }
}
