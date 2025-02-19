/// SNS 로그인 추상 클래스.
abstract class SnsLogin {

  /// 로그인.
  Future<dynamic> login();

  /// 로그아웃.
  void logout();
}