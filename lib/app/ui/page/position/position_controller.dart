import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/data/network/model/base_list_model/paginate_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/workout/model/get_workout_position_detail_response_model.dart';
import 'package:physical_note/app/data/workout/workout_api.dart';
import 'package:physical_note/app/ui/page/my_information/position/position_list_item_ui_state.dart';
import 'package:physical_note/app/utils/pagination/load_page.dart';
import 'package:physical_note/app/utils/pagination/paging_controller_ext.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'position_args.dart';

class PositionController extends BaseController {
  final args = Get.arguments as PositionArgs;

  /// 검색 키워드
  var keyword = "".obsWithController;

  /// 페이지 컨트롤러.
  var pagingController =
      PagingController<int, PositionListItemUiState>(firstPageKey: 0);

  /// 완료 버튼 enabled.
  var isEnabledCompleteButton = false.obs;

  @override
  void onInit() {
    super.onInit();
    pagingController.start((pageKey) => _loadPage(pageKey));
  }

  /// 리프레시.
  Future<void> onRefresh() async {
    pagingController.refresh();
  }

  /// 검색 버튼 클릭.
  void onPressedSearchButton() {
    pagingController.refresh();
  }

  /// 아이템 선택 - 다중 선택 가능..
  Future<void> onPressedListItem(PositionListItemUiState uiState) async {
    final items = pagingController.itemList as List<PositionListItemUiState>;

    final newItems = items.map((item) {
      var newItem = item;
      if (newItem.id == uiState.id) {
        newItem.isSelected = !item.isSelected;
      }
      return newItem;
    }).toList();

    pagingController.itemList = newItems;
    isEnabledCompleteButton.value =
        newItems.where((element) => element.isSelected).isNotEmpty;
  }

  /// 완료 버튼 클릭.
  void onPressedComplete() {
    final items = pagingController.itemList as List<PositionListItemUiState>;
    final selectedItems = items.where((element) => element.isSelected).toList();
    close(result: selectedItems);
  }

  /// 팀 목록 조회.
  Future<LoadPage<int, PositionListItemUiState>> _loadPage(int pageKey) async {
    final workoutId = args.workoutId;

    final workoutAPI = Get.find<WorkoutAPI>();
    final response = await workoutAPI.getWorkoutPositionDetail(
      pageKey: pageKey,
      workoutId: workoutId,
      keyword: keyword.value,
    );

    var isLastPage = true;
    var toUiStates = <PositionListItemUiState>[];

    if (response is PaginateModel) {
      isLastPage = response.last;
      toUiStates =
          response.content.map((e) => _positionListItemUiStateFrom(e)).toList();
    } else {
      final message =
          (response as ServerResponseFailModel?)?.devMessage ?? "서버 에러";
      showToast(message);
    }

    return LoadPage(
      items: toUiStates,
      isLastPage: isLastPage,
      nextPageKey: pageKey + 1,
    );
  }

  /// 아이템 매핑.
  PositionListItemUiState _positionListItemUiStateFrom(
      GetWorkoutPositionDetailResponseModel rawData) {
    return PositionListItemUiState(
      id: rawData.id,
      name: rawData.name,
      isSelected: false,
    );
  }
}
