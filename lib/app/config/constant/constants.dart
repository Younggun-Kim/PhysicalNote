// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import '../env/config.dart';

class Constants {
  /// 달력 최소 날짜.
  static final CALENDAR_MIN_DATE = DateTime(2000, 1, 1);

  /// 달력 최대 날짜.
  static final CALENDAR_MAX_DATE = DateTime(2051, 1, 1);

  /// Pass Url.
  static const PASS_URL = 'https://dev.hajinj.com/page/pass/verify';

  /// Kakao native key.
  static final kakaoNativeKey = Config.isProd
      ? "fde38af09e56b42965bdf5b505f5a332"
      : "fde38af09e56b42965bdf5b505f5a332";

  /// 네이버 아이디 로그인 - 리다이렉트 Url.
  static const naverRedirectUrl = "https://dev.hajinj.com/login";

  /// 네이버 아이디 로그인 - 클라이언트 id.
  static const naverClientId = "ni1NgxkxZL4C9rRQxoed";

  /// 네이버 아이디 로그인 - 시크릿 키.
  static const naverClientSecret = "3R6IYHkr82";
}
