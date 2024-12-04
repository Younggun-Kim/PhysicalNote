import 'package:intl/intl.dart';

extension IntlEx on Intl {
  static bool get isKor => Intl.getCurrentLocale() == 'ko';
}