part of 'translations.dart';

class StringRes {
  static const _uuid = Uuid();

  /// 생성자.
  const StringRes._();

  static String _generateId() => _uuid.v1();

  static final appName = _generateId();

  static final email = _generateId();
  static final emailHint = _generateId();
  static final emailError = _generateId();
  static final password = _generateId();
  static final passwordHint = _generateId();
  static final passwordError = _generateId();
  static final passwordConfirm = _generateId();
  static final passwordNotMatched = _generateId();
  static final simpleSignUp = _generateId();
  static final findId = _generateId();
  static final findPw = _generateId();
  static final login = _generateId();
  static final startWithSns = _generateId();
  static final acceptTerms = _generateId();
  static final allAgree = _generateId();
  static final requiredTermService = _generateId();
  static final requiredTermPrivacy = _generateId();
  static final next = _generateId();
  static final signUp = _generateId();
  static final phoneNumber = _generateId();
  static final phoneNumberError = _generateId();
  static final phoneHint = _generateId();
  static final name = _generateId();
  static final nameError = _generateId();
  static final nameHint = _generateId();
  static final findIdResult = _generateId();
  static final changePassword = _generateId();
  static final category = _generateId();
  static final sports = _generateId();
  static final clickToSelect = _generateId();
  static final amateur = _generateId();
  static final elite = _generateId();
  static final selectCategory = _generateId();
  static final search = _generateId();
  static final select = _generateId();
}
