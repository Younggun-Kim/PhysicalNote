import 'package:intl/intl.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'dart:io' show Platform;

class LocalizationUtil {
  static bool get isKor => Platform.localeName.contains('ko');

  static String getDateStr({
    required String date,
    required String koFormat,
    required String enFormat,
    String originFormat = 'yyyy-MM-dd',
  }) {
    try {
      /// 휴대폰의 언어가 ko(한글)일 때, region(or country)는 판단 안 함
      if (LocalizationUtil.isKor) {
        return date.toDate(originFormat).toFormattedString(koFormat);
      } else {
        return date.toDate(originFormat).toFormattedString(enFormat);
      }
    } catch (e) {
      return date;
    }
  }

  static String getDateStrFromDate({
    required DateTime date,
    required String koFormat,
    required String enFormat,
    String originFormat = 'yyyy-MM-dd',
  }) {
    try {
      if (LocalizationUtil.isKor) {
        return date.toFormattedString(koFormat);
      } else {
        return date.toFormattedString(enFormat);
      }
    } catch (e) {
      return date.toFormattedString(originFormat);
    }
  }
}
