/// 회원 가입 Args.
class SignUpArgs {
  final String passToken;

  final String name;

  final String phone;

  SignUpArgs({required this.passToken, required this.name, required this.phone});
}