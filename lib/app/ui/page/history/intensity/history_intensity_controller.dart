import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/ui/page/history/intensity/item/history_intensity_item_ui_state.dart';
import 'package:physical_note/app/ui/page/history/interface/history_filter_base.dart';
import 'package:physical_note/app/ui/page/intensity_detail/intensity_detail.dart';
import 'package:physical_note/app/utils/pagination/load_page.dart';
import 'package:physical_note/app/utils/pagination/paging_controller_ext.dart';
import 'package:physical_note/app/utils/utils.dart';

mixin HistoryIntensityController on BaseController implements HistoryFilterBase {
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
    final toUiState = List.generate(
        10,
        (index) => HistoryIntensityItemUiState(
            id: index + 1,
            sportLevel: 4,
            sportTime: '2시간 10분',
            physicalLevel: 3,
            physicalTime: '2시간',
            recordDate: DateTime.now()));
    return LoadPage(
      items: toUiState,
      isLastPage: true,
      nextPageKey: pageKey + 1,
    );
  }

  /// 운동강도 상세 이동
  void _modeIntensityDetail({
    required int? intensityId,
    required DateTime recordDate,
  }) {
    final args = IntensityDetailArgs(
      intensityId: intensityId,
      recordDate: recordDate,
    );
    Get.toNamed(RouteType.INTENSITY_DETAIL, arguments: args);
  }

  /// 운동강도 생성
  void recordIntensity({required DateTime recordDate}) {
    _modeIntensityDetail(intensityId: null, recordDate: recordDate);
  }

  /// 운동강도 수정
  void onPressedIntensityItem(HistoryIntensityItemUiState uiState) {
    _modeIntensityDetail(intensityId: uiState.id, recordDate: uiState.recordDate);
  }
}
