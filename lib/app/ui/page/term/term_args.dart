import 'package:physical_note/app/config/constant/user_type.dart';

/// 약관동의 Args.
class TermArgs {
  final UserSnsType snsType;

  final String accessToken;

  TermArgs({required this.snsType, required this.accessToken});
}
