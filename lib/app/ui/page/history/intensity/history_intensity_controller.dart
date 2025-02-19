import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/intensity/intensity_api.dart';
import 'package:physical_note/app/data/intensity/model/get_intensity_paginate_model.dart';
import 'package:physical_note/app/ui/page/history/intensity/item/history_intensity_item_ui_mapper.dart';
import 'package:physical_note/app/ui/page/history/intensity/item/history_intensity_item_ui_state.dart';
import 'package:physical_note/app/ui/page/history/interface/history_filter_base.dart';
import 'package:physical_note/app/ui/page/intensity_detail/intensity_detail.dart';
import 'package:physical_note/app/ui/page/main/main_screen.dart';
import 'package:physical_note/app/utils/pagination/load_page.dart';
import 'package:physical_note/app/utils/pagination/paging_controller_ext.dart';
import 'package:physical_note/app/utils/utils.dart';

mixin HistoryIntensityController on BaseController
    implements HistoryFilterBase {
  @override
  void onInit() {
    super.onInit();
    resetIntensity();
  }

  /// 운동강도 페이지 컨트롤러
  final intensityPagingController =
      PagingController<int, HistoryIntensityItemUiState>(
    firstPageKey: 0,
  );

  /**
   * 메소드
   */

  /// Intensity Controller 초기화
  void resetIntensity() {
    intensityPagingController.start((pageKey) => _loadPage(pageKey));
  }

  /// 페이지 리프레시.
  Future<void> onRefreshIntensity() async {
    intensityPagingController.refresh();
  }

  /// 운동강도 목록 조회.
  Future<LoadPage<int, HistoryIntensityItemUiState>> _loadPage(
    int pageKey,
  ) async {
    if (!Get.isRegistered<IntensityAPI>()) {
      Get.put(IntensityAPI());
    }

    final intensityApi = Get.find<IntensityAPI>();
    final response = await intensityApi.getIntensityList(
      pageKey: pageKey,
      period: dateFilter.value.name.toUpperCase(),
      sortDirection: orderFilter.value.name.toUpperCase(),
    );

    if (response is GetIntensityPaginateModel &&
        response.workoutIntensityList != null) {
      final list = response.workoutIntensityList!;
      final isLastPage = list.last;
      var toUiState = list.content
          .compactMap((e) => historyIntensityItemUiStateFrom(e))
          .toList();

      // 리스트가 없어도 평균을 보여주기 위함
      if (toUiState.isEmpty) {
        toUiState.add(
          HistoryIntensityItemUiState(
            id: '1',
            sportLevel: null,
            sportTime: null,
            physicalLevel: null,
            physicalTime: null,
            recordDate: DateTime.now(),
            onlyAverage: true,
          ),
        );
      }

      if (toUiState.isNotEmpty) {
        // 0번의 평균 값들 넣기
        toUiState[0].lastWeekAverageTime = response.lastWeekAvgWorkoutTime;
        toUiState[0].thisWeekAverageTime = response.thisWeekAvgWorkoutTime;
        toUiState[0].sportLevelAverage = response.sportsAvgIntensityLevel;
        toUiState[0].physicalLevelAverage = response.physicalAvgIntensityLevel;
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

  /// 운동강도 상세 이동
  void _modeIntensityDetail({
    required DateTime recordDate,
  }) async {
    final args = IntensityDetailArgs(
      recordDate: recordDate,
    );
    final result = await Get.toNamed(
      RouteType.INTENSITY_DETAIL,
      arguments: args,
    );
    if (result is bool && result) {
      onRefreshIntensity();
      if (Get.isRegistered<MainScreenController>()) {
        final mainController = Get.find<MainScreenController>();
        mainController.onRefresh(MainTabIndex.home);
      }
    }
  }

  /// 운동강도 생성
  void recordIntensity({required DateTime recordDate}) {
    _modeIntensityDetail(recordDate: recordDate);
  }

  /// 운동강도 수정
  void onPressedIntensityItem(HistoryIntensityItemUiState uiState) {
    _modeIntensityDetail(recordDate: uiState.recordDate);
  }
}
