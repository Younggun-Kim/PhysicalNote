import 'package:physical_note/app/data/workout/model/get_workout_category_response_list_item_model.dart';
import 'package:physical_note/app/ui/page/search_category/item/search_category_list_item_ui_state.dart';
import 'package:physical_note/app/ui/page/search_category/search_category.dart';

extension SearchCategoryListUiMapper on SearchCategoryController {

  /// 종목 아이템 매핑
  SearchCategoryListItemUiState searchCategoryListItemUiStateFrom(
      GetWorkoutCategoryResponseListItemModel model) {
    return SearchCategoryListItemUiState(
      id: model.id,
      name: model.name,
      isSelected: false,
    );
  }
}
