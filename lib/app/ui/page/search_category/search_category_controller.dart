import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/data/workout/model/get_workout_category_response_list_item_model.dart';
import 'package:physical_note/app/data/workout/workout_api.dart';
import 'package:physical_note/app/ui/page/search_category/search_category_list_ui_mapper.dart';
import 'package:physical_note/app/utils/pagination/load_page.dart';
import 'package:physical_note/app/utils/pagination/paging_controller_ext.dart';
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

  final pagingController =
  PagingController<int, SearchCategoryListItemUiState>(firstPageKey: 1);

  /// 페이지 로딩
  Future<void> onRefresh() async {
    pagingController.refresh();
  }

  /// 아이템 선택 여부.
  late final isSelectedListItem = items.behaviorStream
      .map((event) => event.firstWhereOrNull((element) => element.isSelected))
      .map((event) => event != null)
      .toObs(false);

  @override
  onInit() {

    pagingController.start((pageKey) => loadPage(pageKey));
  }

  /// 검색 버튼 클릭.
  Future<void> onPressedSearchButton() async {
    logger.i("검색 버튼 클릭");
    final api = Get.find<WorkoutAPI>();
    final response = await api.getWorkoutCategory(0);


    logger.i("response.content: ${response.content}");

    final toUiState = response.content
        .map((e) => searchCategoryListItemUiStateFrom(e as GetWorkoutCategoryResponseListItemModel))
        .toList();

    items.value = toUiState;
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
