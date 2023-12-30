import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:physical_note/app/utils/logger/logger.dart';
import 'package:physical_note/app/utils/sns/sns_login.dart';


/// 카카오 로그인.
class KakaoLogin extends SnsLogin {
  late final _userApi = UserApi.instance;

  /// 카카오 초기화.
  KakaoLogin init(String nativeAppKey) {
    KakaoSdk.init(nativeAppKey: nativeAppKey);
    return this;
  }

  ///  로그인.
  @override
  Future<String?> login() async {
    try {
      late OAuthToken oAuthToken;
      if (await isKakaoTalkInstalled()) {
        oAuthToken = await _userApi.loginWithKakaoTalk();
      } else {
        oAuthToken = await _userApi.loginWithKakaoAccount();
      }

      return oAuthToken.accessToken;
    } catch (e) {
      logger.e(e);
      return null;
    } finally {
      logout();
    }
  }

  /// 로그아웃.
  @override
  void logout() {
    _userApi.logout();
  }
}
