import 'package:get/get.dart';

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
}
