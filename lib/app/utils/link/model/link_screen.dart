import 'package:get/get.dart';

/// 인 앱 링크 화면 이동 타입
enum LinkScreen {
  /// 메인 - 홈
  home,

  /// 메인 - 데이터
  data,

  /// 메인 - 피드백
  feedback,

  /// 메인 - 데이터 - 부상관리
  injury;

  // Screen String -> LinkScreen
  static LinkScreen from(String? screen) =>
      LinkScreen.values
          .firstWhereOrNull((e) => e.name == screen?.toLowerCase()) ??
      LinkScreen.home;
}
