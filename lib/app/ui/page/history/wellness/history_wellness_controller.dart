import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/wellness/model/get_wellness_paginate_model.dart';
import 'package:physical_note/app/data/wellness/wellness_api.dart';
import 'package:physical_note/app/ui/page/history/wellness/item/history_wellness_item_ui_mapper.dart';
import 'package:physical_note/app/ui/page/main/main_screen.dart';
import 'package:physical_note/app/ui/page/wellness_detail/wellness_detail.dart';
import 'package:physical_note/app/utils/pagination/load_page.dart';
import 'package:physical_note/app/utils/pagination/paging_controller_ext.dart';
import 'package:physical_note/app/utils/utils.dart';

import '../interface/history_filter_base.dart';
import 'item/history_wellness_item_ui_state.dart';

mixin HistoryWellnessController on BaseController implements HistoryFilterBase {
  @override
  void onInit() {
    super.onInit();
    resetWellness();
  }

  void resetWellness() {
    wellnessPagingController.start((pageKey) => _loadPage(pageKey));
  }

  /// 웰리니스 페이징 스크롤.
  final wellnessPagingController =
      PagingController<int, HistoryWellnessItemUiState>(firstPageKey: 0);

  /// 페이지 리프레시.
  Future<void> onRefreshWellness() async {
    wellnessPagingController.refresh();
  }

  /// 웰리니스 목록 조회.
  Future<LoadPage<int, HistoryWellnessItemUiState>> _loadPage(
    int pageKey,
  ) async {
    final wellnessApi = Get.find<WellnessAPI>();
    final response = await wellnessApi.getWellnessList(
      page: pageKey,
      period: dateFilter.value.name.toUpperCase(),
      sortDirection: orderFilter.value.name.toUpperCase(),
    );

    if (response is GetWellnessPaginateModel && response.wellnessList != null) {
      final isLastPage = response.wellnessList!.last;
      var toUiState = response.wellnessList!.content
          .compactMap((e) => historyWellnessItemUiStateFrom(e))
          .toList();

      if (toUiState.isNotEmpty) {
        toUiState[0]
          ..sleepAvg = response.sleepAvg
          ..stressAvg = response.stressAvg
          ..fatigueAvg = response.fatigueAvg
          ..muscleSorenessAvg = response.muscleSorenessAvg
          ..urineAvg = response.urineAvg
          ..weightAvg = response.weightAvg
          ..differenceFat = response.differenceFat?.extractParseInt();
      }

      return LoadPage(
        items: toUiState,
        isLastPage: isLastPage,
        nextPageKey: pageKey + 1,
      );
    } else {
      return LoadPage(items: [], isLastPage: true, nextPageKey: 0);
    }
  }

  /// 웰리니스 상세 이동
  void _moveWellnessDetail({
    required int? wellnessId,
    required DateTime recordDate,
  }) async {
    final args = WellnessDetailArgs(
      wellnessId: wellnessId,
      recordDate: recordDate,
    );

    final response = await Get.toNamed(
      RouteType.WELLNESS_DETAIL,
      arguments: args,
    );

    if (response is bool && response) {
      onRefreshWellness();

      if(Get.isRegistered<MainScreenController>()) {
        final mainController = Get.find<MainScreenController>();
        mainController.onRefresh(MainTabIndex.home);
      }
    }
  }

  /// 웰리니스 생성
  void recordWellness({required DateTime recordDate}) {
    _moveWellnessDetail(wellnessId: null, recordDate: recordDate);
  }

  /// 웰리니스 수정
  void onPressedWellnessItem(HistoryWellnessItemUiState uiState) {
    final recordDate = DateFormat('yyyy-MM-dd').parse(uiState.recordDate);
    _moveWellnessDetail(wellnessId: uiState.id, recordDate: recordDate);
  }
}
