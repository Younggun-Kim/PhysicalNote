class MyInformationArgs {
  /// 운동 Id.
  final int? workoutId;

  /// 엘리트 여부.
  final bool? isElite;

  /// 홈에서 진입 여부.
  final bool isEnteredFromHome;


  MyInformationArgs({
    this.workoutId,
    this.isElite,
    required this.isEnteredFromHome,
  });
}
