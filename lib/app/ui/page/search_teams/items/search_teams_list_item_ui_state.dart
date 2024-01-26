class SearchTeamsListItemUiState {
  int id;

  /// 이미지.
  String? imageUrl;

  /// 클럽명.
  String clubName;

  /// 코치명.
  String coachName;

  /// 선택여부.
  bool isSelected;

  get clubAndCoach => "$clubName / $coachName";

  SearchTeamsListItemUiState({
    required this.id,
    this.imageUrl,
    required this.clubName,
    required this.coachName,
    this.isSelected = false,
  });
}
