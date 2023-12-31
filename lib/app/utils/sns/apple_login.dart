import 'package:physical_note/app/utils/logger/logger.dart';
import 'package:physical_note/app/utils/sns/apple_result.dart';
import 'package:physical_note/app/utils/sns/sns_login.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLogin extends SnsLogin {
  /// 로그인.
  @override
  Future<AppleResult?> login() async {
    try {
      var credential = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);

      final id = credential.userIdentifier;
      final token = credential.identityToken;

      if (id == null || token == null) {
        return null;
      }

      return AppleResult(id: id, token: token);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  /// 로그아웃.
  @override
  void logout() {
    // ..
  }
}
