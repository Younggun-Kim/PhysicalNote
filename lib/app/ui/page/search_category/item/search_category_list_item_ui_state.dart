class SearchCategoryListItemUiState {
  int id;

  String name;

  bool isSelected;

  SearchCategoryListItemUiState({
    required this.id,
    required this.name,
    this.isSelected = false,
  });
}
