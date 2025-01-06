class SearchCategoryListItemUiState {
  int id;

  String name;

  bool isSelected;

  bool isFoot;

  SearchCategoryListItemUiState({
    required this.id,
    required this.name,
    this.isSelected = false,
    this.isFoot = true,
  });
}
