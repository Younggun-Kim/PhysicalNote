/// 포지션 아이템.
class PositionListItemUiState {
  final int id;

  final String name;

  bool isSelected;

  PositionListItemUiState({
    required this.id,
    required this.name,
    this.isSelected = false,
  });
}
