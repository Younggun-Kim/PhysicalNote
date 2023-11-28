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

  /// 페이지 컨트롤러.
  final pagingController =
      PagingController<int, SearchCategoryListItemUiState>(firstPageKey: 0);

  /// 카테고리 선택 여부.
  final isSelectedCategory = false.obs;

  @override
  onInit() {
    super.onInit();
    pagingController.start((pageKey) => loadPage(pageKey));
  }

  /// 검색 버튼 클릭.
  Future<void> onPressedSearchButton() async => onRefresh();

  /// 페이지 리프레시.
  Future<void> onRefresh() async {
    pagingController.refresh();
  }

  /// 리스트 선택 클릭.
  Future<void> onPressedListItem(SearchCategoryListItemUiState uiState) async {
    final items =
        pagingController.itemList as List<SearchCategoryListItemUiState>;

    final newItems = items.map((item) {
      var newItem = item;
      newItem.isSelected = newItem.id == uiState.id;
      return newItem;
    }).toList();

    pagingController.itemList = newItems;
    isSelectedCategory.value = newItems.any((element) => element.isSelected == true);
  }

  /// 다음 버튼 클릭.
  void onPressedNextButton() {
    var selectedItem = pagingController.itemList?.firstWhere((element) => element.isSelected);
    close(result: selectedItem);
  }

  /// 페이지 로딩.
  Future<LoadPage<int, SearchCategoryListItemUiState>> loadPage(
      int pageKey) async {
    final api = Get.find<WorkoutAPI>();
    final response = await api.getWorkoutCategory(page: pageKey);

    final isLastPage = response.last;
    final toUiStates = response.content
        .map((e) => searchCategoryListItemUiStateFrom(
            e as GetWorkoutCategoryResponseListItemModel))
        .toList();

    return LoadPage(
      items: toUiStates,
      isLastPage: isLastPage,
      nextPageKey: pageKey + 1,
    );
  }
}
