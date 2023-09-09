part of 'translations.dart';

class StringRes {
  static const _uuid = Uuid();

  /// 생성자.
  const StringRes._();

  static String _generateId() => _uuid.v1();

  static final appName = _generateId();
}