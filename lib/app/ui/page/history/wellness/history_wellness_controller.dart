import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/wellness/model/get_wellness_paginate_model.dart';
import 'package:physical_note/app/data/wellness/wellness_api.dart';
import 'package:physical_note/app/ui/page/history/wellness/item/history_wellness_item_ui_mapper.dart';
import 'package:physical_note/app/ui/page/wellness_detail/wellness_detail.dart';
import 'package:physical_note/app/utils/extensions/list_extension.dart';
import 'package:physical_note/app/utils/getx/utils_getx.dart';
import 'package:physical_note/app/utils/pagination/load_page.dart';
import 'package:physical_note/app/utils/pagination/paging_controller_ext.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'item/history_wellness_item_ui_state.dart';

mixin HistoryWellnessController on BaseController {
  @override
  void onInit() {
    super.onInit();
    resetWellness();
  }

  void resetWellness() {
    wellnessPagingController.start((pageKey) => _loadPage(pageKey));
  }

  final wellnessScrollController = ScrollController();

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
      period: 'ALL',
      sortDirection: 'ASC',
    );

    if (response is GetWellnessPaginateModel && response.wellnessList != null) {
      final isLastPage = response.wellnessList!.last;
      var toUiState = response.wellnessList!.content
          .compactMap((e) => historyWellnessItemUiStateFrom(e))
          .toList();

      if (toUiState.isNotEmpty) {
        toUiState[0].sleepAvg = response.sleepAvg;
        toUiState[0].stressAvg = response.stressAvg;
        toUiState[0].fatigueAvg = response.fatigueAvg;
        toUiState[0].muscleSorenessAvg = response.muscleSorenessAvg;
        toUiState[0].urineAvg = response.urineAvg;
        toUiState[0].weightAvg = response.weightAvg;
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
  void _moveWellnessDetail({required int? wellnessId}) {
    final args = WellnessDetailArgs(wellnessId: wellnessId);
    Get.toNamed(RouteType.WELLNESS_DETAIL, arguments: args);
  }

  /// 웰리니스 생성
  void recordWellness() {
    _moveWellnessDetail(wellnessId: null);
  }

  /// 웰리니스 수정
  void onPressedWellnessItem(int wellnessId) {
    _moveWellnessDetail(wellnessId: wellnessId);
  }
}
