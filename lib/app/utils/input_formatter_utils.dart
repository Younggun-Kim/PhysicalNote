import 'package:flutter/services.dart';

/// TextField, TextView의 InputFormatter Utils.
class InputFormatterUtils {
  /// 숫자, 점 = 소숫점
  static TextInputFormatter digitAndDot = FilteringTextInputFormatter.allow(
    RegExp(r'^\d{0,3}(\.\d?)?$'),
  );
}
