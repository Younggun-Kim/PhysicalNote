import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';

/// 유저 Sns 타입.
enum UserSnsType {
  idPw,
  naver,
  kakao,
  apple;

  /// Key로 초기화
  static UserSnsType? from(String? key) =>
      values.firstWhereOrNull((element) => element.toString() == key);

  @override
  String toString() {
    super.toString();
    switch (this) {
      case idPw:
        return "IDPW";
      case naver:
        return "NAVER";
      case kakao:
        return "KAKAO";
      case apple:
        return "APPLE";
    }
  }

  /// 이미지로 변환.
  String toImage() {
    switch (this) {
      case idPw:
        return Assets.imgEmail;
      case naver:
        return Assets.imgNaver;
      case kakao:
        return Assets.imgKakao;
      case apple:
        return Assets.imgApple;
    }
  }

  /// -회원으로 변환.
  String toUser() {
    switch (this) {
      case idPw:
        return StringRes.email.tr;
      case naver:
        return StringRes.naverUser.tr;
      case kakao:
        return StringRes.kakaoUser.tr;
      case apple:
        return StringRes.appleUser.tr;
    }
  }
}
