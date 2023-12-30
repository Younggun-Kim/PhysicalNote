import 'package:physical_note/app/config/constant/user_type.dart';

/// 약관동의 Args.
class TermArgs {
  final UserSnsType snsType;

  final String token;

  TermArgs({required this.snsType, required this.token});
}
