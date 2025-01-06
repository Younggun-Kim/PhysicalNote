class MyInformationArgs {
  /// 운동 Id.
  final int? workoutId;

  /// 손발여부
  final bool isFoot;

  /// 엘리트 여부.
  final bool? isElite;

  /// 홈에서 진입 여부.
  final bool isEnteredFromHome;

  /// passCode - Apple 인 경우 필요.
  final String? passCode;

  MyInformationArgs({
    this.workoutId,
    this.isFoot = true,
    this.isElite,
    required this.isEnteredFromHome,
    this.passCode,
  });
}
