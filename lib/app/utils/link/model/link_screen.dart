import 'package:get/get.dart';

/**
 * 인 앱 링크 화면 이동 타입
 */
enum LinkScreen {
  home,
  data,
  feedback;

  // Screen String -> LinkScreen
  static LinkScreen from(String? screen) =>
      LinkScreen.values
          .firstWhereOrNull((e) => e.name == screen?.toLowerCase()) ??
      LinkScreen.home;
}
