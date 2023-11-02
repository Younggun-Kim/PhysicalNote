class SearchTeamsListItemUiState {
  int id;

  /// 이미지.
  String? imageUrl;

  /// 클럽명.
  String clubName;

  /// 코치명.
  String coachName;

  bool isSelected;

  SearchTeamsListItemUiState({
    required this.id,
    this.imageUrl,
    required this.clubName,
    required this.coachName,
    this.isSelected = false,
  });
}
