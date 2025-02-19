import 'package:get/get.dart';
import 'package:physical_note/app/utils/utils.dart';

class Regex {
  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  static bool isPassword(String s) =>
      hasMatch(s, r'^(?=.*?[a-z-A-Z-])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  static bool isPhoneNumber(String s) => s.isPhoneNumber && s.length == 11;

  /// 생년월일 정규식
  static bool isBirth(String s) =>
      LocalizationUtil.isKor ? _isKoBirth(s) : _isEnBirth(s);

  static bool _isKoBirth(String s) => hasMatch(
        s,
        r'^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$',
      );

  static bool _isEnBirth(String s) => hasMatch(
        s,
        r'^(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])(19[0-9][0-9]|20\d{2})$',
      );
}
