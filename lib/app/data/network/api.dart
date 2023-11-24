import 'package:get/get.dart';

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
      ..baseUrl = server
      ..defaultContentType = 'application/json'
      ..timeout = const Duration(seconds: 10)
      ..addRequestModifier<dynamic>((request) {
        // request.headers['Authorization'] = 'token value';
        return request;
      });
  }
}
