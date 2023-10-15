import 'package:get/get.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'item/search_category_list_item_ui_state.dart';

class SearchCategoryController extends BaseController {

  /// 검색어 컨트롤러.
  final keyword = "".obsWithController;

  /// 리스트 목록.
  final items = <SearchCategoryListItemUiState>[
    SearchCategoryListItemUiState(id: 1, name: "1"),
    SearchCategoryListItemUiState(id: 2, name: "2"),
    SearchCategoryListItemUiState(id: 3, name: "3"),
    SearchCategoryListItemUiState(id: 4, name: "4"),
    SearchCategoryListItemUiState(id: 5, name: "5"),
    SearchCategoryListItemUiState(id: 6, name: "6"),
  ].obs;
}