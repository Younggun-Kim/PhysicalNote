import 'package:get/get.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'item/search_category_list_item_ui_state.dart';
import 'search_category_args.dart';

class SearchCategoryController extends BaseController {
  /// args.
  final args = Get.arguments as SearchCategoryArgs;

  /// Sports 여부.
  late final isSports = args.isSports;

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

  /// 아이템 선택 여부.
  late final isSelectedListItem = items.behaviorStream
      .map((event) => event.firstWhereOrNull((element) => element.isSelected))
      .map((event) => event != null)
      .toObs(false);

  /// 검색 버튼 클릭.
  void onPressedSearchButton() {
    logger.d("검색 클릭");
  }

  /// 리스트 선택 클릭.
  Future<void> onPressedListItem(SearchCategoryListItemUiState uiState) async {
    var newItems = items.map((element) {
      element.isSelected = element.id == uiState.id;
      return element;
    });
    items.value = newItems.toList();
  }

  /// 다음 버튼 클릭.
  void onPressedNextButton() {
    close(result: isSports ? "Sports" : "Category");
  }
}
