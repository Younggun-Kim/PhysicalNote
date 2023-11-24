/// 유저 Sns 타입.
enum UserSnsType {
  idPw('IDPW'),
  naver('NAVER'),
  kakao('KAKAO'),
  apple('APPLE');

  const UserSnsType(this.key);

  final String key;
}
