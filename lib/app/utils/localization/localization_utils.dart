import 'package:intl/intl.dart';
import 'package:physical_note/app/utils/utils.dart';

class LocalizationUtil {
  static String getDateStr({
    required String date,
    required String koFormat,
    required String enFormat,
    String originFormat = 'yyyy-MM-dd',
  }) {
    if (Intl.getCurrentLocale() == 'ko_KR') {
      return date.toDate(originFormat).toFormattedString(koFormat);
    } else {
      return date.toDate(originFormat).toFormattedString(enFormat);
    }
    return '';
  }
}
