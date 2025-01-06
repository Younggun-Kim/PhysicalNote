import 'package:physical_note/app/config/constant/use_main_type.dart';

class MyInformationArgs {
  /// 운동 Id.
  final int? workoutId;

  /// 손발여부
  final UseMain useMain;

  /// 엘리트 여부.
  final bool? isElite;

  /// 홈에서 진입 여부.
  final bool isEnteredFromHome;

  /// passCode - Apple 인 경우 필요.
  final String? passCode;

  MyInformationArgs({
    this.workoutId,
    this.useMain = UseMain.none,
    this.isElite,
    required this.isEnteredFromHome,
    this.passCode,
  });
}
