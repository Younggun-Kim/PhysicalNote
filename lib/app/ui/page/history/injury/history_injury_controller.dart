import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/injury/injury_api.dart';
import 'package:physical_note/app/data/network/model/base_list_model/paginate_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/resources/strings/translations.dart';
import 'package:physical_note/app/ui/page/history/injury/item/history_injury_item_ui_mapper.dart';
import 'package:physical_note/app/ui/page/history/injury/item/history_injury_item_ui_state.dart';
import 'package:physical_note/app/ui/page/history/interface/history_filter_base.dart';
import 'package:physical_note/app/ui/page/injury_detail/injury_detail.dart';
import 'package:physical_note/app/utils/extensions/list_extension.dart';
import 'package:physical_note/app/utils/pagination/load_page.dart';
import 'package:physical_note/app/utils/pagination/paging_controller_ext.dart';
import 'package:physical_note/app/utils/utils.dart';

mixin HistoryInjuryController on BaseController implements HistoryFilterBase {
  @override
  void onInit() {
    super.onInit();
    refreshInjury();
  }

  /// 운동강도 페이지 컨트롤러
  final injuryPagingController =
      PagingController<int, HistoryInjuryItemUiState>(
    firstPageKey: 0,
  );

  /**
   * 메소드
   */

  /// Intensity Controller 초기화
  void refreshInjury() {
    injuryPagingController.start((pageKey) => _loadPage(pageKey));
  }

  /// 페이지 리프레시.
  Future<void> onRefreshInjury() async {
    injuryPagingController.refresh();
  }

  /// 부상체크 목록 조회.
  Future<LoadPage<int, HistoryInjuryItemUiState>> _loadPage(
    int pageKey,
  ) async {
    final injuryApi = Get.find<InjuryAPI>();
    final response = await injuryApi.getInjuryList(
      page: pageKey,
      period: dateFilter.value.name.toUpperCase(),
      sortDirection: orderFilter.value.name.toUpperCase(),
      recoveryYn: isRecovery.value,
    );

    var isLastPage = true;
    var toUiStates = <HistoryInjuryItemUiState>[];

    if (response is PaginateModel) {
      isLastPage = response.last;
      toUiStates = response.content
          .compactMap((e) => historyInjuryItemUiStateFrom(e))
          .toList();
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }

    return LoadPage(
      items: toUiStates,
      isLastPage: isLastPage,
      nextPageKey: pageKey + 1,
    );
  }

  /// 부상관리 상세 이동
  void _modeInjuryDetail({
    required int? injuryId,
    required DateTime recordDate,
  }) async {
    final args = InjuryDetailArgs(
      injuryId: injuryId,
      recordDate: recordDate,
    );
    final result = await Get.toNamed(
      RouteType.INJURY_DETAIL,
      arguments: args,
    );
    if (result is bool && result) {
      onRefreshInjury();
    }
  }

  /// 부상관리 생성
  void recordInjury({required DateTime recordDate}) {
    _modeInjuryDetail(injuryId: null, recordDate: recordDate);
  }

  /// 부상관리 수정
  void onPressedInjuryItem(HistoryInjuryItemUiState uiState) {
    _modeInjuryDetail(
      injuryId: uiState.id,
      recordDate: uiState.formattedRecordDate,
    );
  }
}
