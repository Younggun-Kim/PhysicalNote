import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/sns_type.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/user/user_storage.dart';
import 'package:physical_note/app/utils/sns/kakao_login.dart';

class Logout {
  static void logout() async {
    final userStorage = UserStorage();

    /// 저장된 토근 삭제
    userStorage.apiKey.val = "";

    /// FCM 토큰 삭제
    await FirebaseMessaging.instance.deleteToken();


    /// 네이버 로그아웃.
    if (userStorage.snsType.val == UserSnsType.naver.toString()) {
      FlutterNaverLogin.logOutAndDeleteToken();
    }

    /// 카카오 로그아웃.
    if (userStorage.snsType.val == UserSnsType.kakao.toString()) {
      final kakaoLogin = Get.find<KakaoLogin>();
      kakaoLogin.logout();
    }

    userStorage.snsType.val = "";

    /// 로그인으로 이동.
    Get.offAllNamed(RouteType.LOGIN);
  }
}