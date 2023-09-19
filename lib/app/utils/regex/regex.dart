import 'package:get/get.dart';

class Regex {
  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  static bool isPassword(String s) =>
      hasMatch(s, r'^(?=.*?[a-z-A-Z-])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  static bool isPhoneNumber(String s) => s.isPhoneNumber && s.length == 11;
}
