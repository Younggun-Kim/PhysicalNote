import 'dart:io';

import 'package:intl/intl.dart';
import 'package:physical_note/app/utils/utils.dart';

extension DateEx on DateTime {
  /// 날짜 포맷 변경
  String toFormattedString(String format) {
    return DateFormat(format, Platform.localeName).format(this);
  }
}

extension StringToDateEx on String {
  /// String To Date
  DateTime toDate(String format) {
    return DateFormat(format, Platform.localeName).parse(this);
  }
}

extension StringToStringFormatEx on String {
  bool _isValidTimeFormat(String timeString) {
    // 정규식 패턴: '00:00:00' 형식을 검증
    final RegExp timeRegExp = RegExp(r'^([01]\d|2[0-3]):([0-5]\d):([0-5]\d)$');

    // timeString이 정규식 패턴에 맞는지 확인
    return timeRegExp.hasMatch(timeString);
  }

  /// '00:00:00' To '0시간 0분'
  String toHourAndMinute() {
    if (!_isValidTimeFormat(this)) {
      logger.e('시간 형식이 맞지 않습니다.');
      return this;
    }
    String timeString = this;

    // 시간, 분, 초 분리
    List<String> parts = timeString.split(':');
    int hours = int.parse(parts[0]);
    String minutes = parts[1];

    return '$hours:$minutes';
  }
}
