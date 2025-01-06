import 'package:physical_note/app/utils/sns/sns_login.dart';

/// 네이버 로그인.
class NaverLogin extends SnsLogin {
  @override
  Future<String?> login() async {
    return Future.error('');
    // try {
    //   await FlutterNaverLogin.logIn();
    //   final accessToken = await FlutterNaverLogin.currentAccessToken;
    //
    //   logger.i("Naver Access Token : ${accessToken.accessToken}");
    //
    //   return accessToken.accessToken;
    // } catch (e) {
    //   logger.e(e);
    //   return null;
    // } finally {
    //   logout();
    // }
  }

  @override
  void logout() {
    // FlutterNaverLogin.logOut();
  }
}
