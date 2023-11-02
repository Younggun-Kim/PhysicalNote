import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/search_teams/items/search_teams_list_item_ui_state.dart';
import 'package:physical_note/app/utils/getx/utils_getx.dart';
import '../../../utils/logger/logger.dart';

class SearchTeamsController extends BaseController {
  /// 검색어.
  var keyword = "".obsWithController;

  /// 아이템 목록.
  var items = <SearchTeamsListItemUiState>[].obs;

  /// 검색 버튼 클릭.
  void onPressedSearchButton() {
    logger.d("검색 클릭 : ${keyword.value}");

    items.value = List.generate(
        20,
        (index) => SearchTeamsListItemUiState(
            id: index,
            clubName: "클럽$index",
            coachName: "코치$index",
            isSelected: false));
  }

  /// 아이템 선택.
  Future<void> onPressedListItem(SearchTeamsListItemUiState uiState) async {
    var newItems = items.map((element) {
      element.isSelected = element.id == uiState.id;
      return element;
    });
    items.value = newItems.toList();
  }
}
