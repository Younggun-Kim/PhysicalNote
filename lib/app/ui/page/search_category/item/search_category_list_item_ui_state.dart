import 'package:physical_note/app/config/constant/use_main_type.dart';

class SearchCategoryListItemUiState {
  int id;

  String name;

  UseMain useMain;

  bool isSelected;

  SearchCategoryListItemUiState({
    required this.id,
    required this.name,
    this.useMain = UseMain.none,
    this.isSelected = false,
  });
}
