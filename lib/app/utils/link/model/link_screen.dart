import 'package:get/get.dart';

/// 인 앱 링크 화면 이동 타입
/// 🔥🔥타입 추가 순서 - 주의🔥🔥
/// 1. LinkScreen에 이동 타입 추가
/// 2. in_link.dart -> _openInAppLink() 에 화면 이동 추가
/// 3. `flutter pub run build_runner run` 실행
///  - LinkData 모델에서 LinkScreen 데이터 타입으로 사용하고 있어서 설정해줘야 한다.
enum LinkScreen {
  /// 메인 - 홈
  home,

  /// 메인 - 데이터
  data,

  /// 메인 - 데이터 - 웰리니스.
  wellness,

  /// 메인 - 데이터 - 부상관리
  injury,

  /// 메인 - 피드백
  feedback,

  /// 메인 - 피드백 - 팀 일정 등록(피드백과 동일 화면)
  calendar;

  // Screen String -> LinkScreen
  static LinkScreen from(String? screen) =>
      LinkScreen.values
          .firstWhereOrNull((e) => e.name == screen?.toLowerCase()) ??
      LinkScreen.home;
}
