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


   /// 중복제거를 위해 '==' 연산자 오버라이딩.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PositionListItemUiState &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              isSelected == other.isSelected;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isSelected.hashCode;
}
