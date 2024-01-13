import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/data/workout/model/get_workout_category_response_list_item_model.dart';
import 'package:physical_note/app/data/workout/model/get_workout_detail_response_list_item_model.dart';
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

  /// 기존의 선택된 종목 Id.
  late int? selectedId = isSports ? args.sportsId : args.categoryId;

  /// 검색어 컨트롤러.
  final keyword = "".obsWithController;

  /// 페이지 컨트롤러.
  final pagingController =
      PagingController<int, SearchCategoryListItemUiState>(firstPageKey: 0);

  /// 카테고리 선택 여부.
  late final isSelectedItem = (selectedId != null).obs;

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

    final selectedItem =
        newItems.firstWhereOrNull((element) => element.isSelected == true);
    isSelectedItem.value = selectedItem != null;
    selectedId = selectedItem?.id;
  }

  /// 다음 버튼 클릭.
  void onPressedNextButton() {
    final selectedItem =
        pagingController.itemList?.firstWhere((element) => element.isSelected);
    close(result: selectedItem);
  }

  /// 페이지 로딩
  Future<LoadPage<int, SearchCategoryListItemUiState>> loadPage(int pageKey) {
    return args.isSports ? loadPageSports(pageKey) : loadPageCategory(pageKey);
  }

  /// 페이지 로딩.
  Future<LoadPage<int, SearchCategoryListItemUiState>> loadPageCategory(
      int pageKey) async {
    final api = Get.find<WorkoutAPI>();

    final response = await api.getWorkoutCategory(
      page: pageKey,
      keyword: keyword.value,
    );

    final isLastPage = response.last;
    final toUiStates = response.content
        .map((e) => searchCategoryListItemUiStateFrom(
            e as GetWorkoutCategoryResponseListItemModel, e.id == selectedId))
        .toList();

    return LoadPage(
      items: toUiStates,
      isLastPage: isLastPage,
      nextPageKey: pageKey + 1,
    );
  }

  /// 페이지 로딩 - 스포츠.
  Future<LoadPage<int, SearchCategoryListItemUiState>> loadPageSports(
      int pageKey) async {
    final categoryId = args.categoryId;

    if (categoryId == null) {
      return Future.error(Error());
    }

    final api = Get.find<WorkoutAPI>();

    final response = await api.getWorkoutDetail(
      pageKey: pageKey,
      categoryId: categoryId,
      keyword: keyword.value,
    );

    final isLastPage = response.last;
    final toUiStates = response.content
        .map((e) => searchCategoryListItemUiStateFromSports(
            e as GetWorkoutDetailResponseItemModel, e.id == selectedId))
        .toList();

    return LoadPage(
      items: toUiStates,
      isLastPage: isLastPage,
      nextPageKey: pageKey + 1,
    );
  }
}
