import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class KakaoLogin {
  /// 카카오 초기화.
  KakaoLogin init(String nativeAppKey) {
    KakaoSdk.init(nativeAppKey: nativeAppKey);
    return this;
  }
}