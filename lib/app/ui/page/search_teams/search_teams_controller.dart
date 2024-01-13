import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/data/network/model/base_list_model/paginate_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/teams/teams_api.dart';
import 'package:physical_note/app/ui/page/search_teams/items/search_teams_list_item_ui_state.dart';
import 'package:physical_note/app/ui/page/search_teams/search_teams_list_ui_mapper.dart';
import 'package:physical_note/app/utils/getx/utils_getx.dart';
import 'package:physical_note/app/utils/pagination/load_page.dart';
import 'package:physical_note/app/utils/pagination/paging_controller_ext.dart';

class SearchTeamsController extends BaseController {
  /// 검색어.xw
  var keyword = "".obsWithController;

  /// 페이지 컨트롤러.
  var pagingController =
      PagingController<int, SearchTeamsListItemUiState>(firstPageKey: 0);

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

  /// 아이템 선택.
  Future<void> onPressedListItem(SearchTeamsListItemUiState uiState) async {
    close(result: uiState);
  }

  /// 팀 목록 조회.
  Future<LoadPage<int, SearchTeamsListItemUiState>> _loadPage(
      int pageKey) async {
    final teamsApi = Get.find<TeamsAPI>();
    final response = await teamsApi.getTeams(page: pageKey, keyword: keyword.value);

    var isLastPage = true;
    var toUiStates = <SearchTeamsListItemUiState>[];

    if (response is PaginateModel) {
      isLastPage = response.last;
      toUiStates = response.content
          .map((e) => searchTeamsListItemUiStateFrom(e))
          .toList();
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
}
