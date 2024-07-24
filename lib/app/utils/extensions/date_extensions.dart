import 'package:intl/intl.dart';

extension DateEx on DateTime {
  /// 날짜 포맷 변경
  String toFormattedString(String format) {
    return DateFormat(format, 'ko_KR').format(this);
  }
}