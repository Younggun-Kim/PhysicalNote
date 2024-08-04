import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/config/constant/injury_level_type.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
import 'package:physical_note/app/config/constant/muscle_type.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/ui/page/history/injury/item/history_injury_item_ui_state.dart';
import 'package:physical_note/app/ui/page/history/interface/history_filter_base.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_body_parts_type.dart';
import 'package:physical_note/app/ui/page/intensity_detail/intensity_detail.dart';
import 'package:physical_note/app/utils/pagination/load_page.dart';
import 'package:physical_note/app/utils/pagination/paging_controller_ext.dart';
import 'package:physical_note/app/utils/utils.dart';

import '../../injury_check/type/injury_check_direction_type.dart';

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
    return LoadPage(
      items: [
        HistoryInjuryItemUiState(
          id: 1,
          injuryLevelType: InjuryLevelType.fromLevel(2),
          muscleType: MuscleType.adductorMagnus,
          recoveryYn: true,
          recordDate: '23.07.15',
          recoveryDate: '23.08.30',
          injuryType: InjuryType.contact,
          direction: InjuryCheckDirectionType.front,
          bodyPart: InjuryCheckBodyPartsType.leftLeg,
          comment: 'fefefe',
        ),
        HistoryInjuryItemUiState(
          id: 2,
          injuryLevelType: null,
          muscleType: null,
          recoveryYn: true,
          recordDate: '23.07.15',
          recoveryDate: '23.08.30',
          injuryType: InjuryType.disease,
          direction: null,
          bodyPart: null,
          comment:
              'feffefefefefefefeefefeffefefefefefefeefefeffefefefefefefeefefeffefefefefefefeefefeffefefefefefefeefefeffefefefefefefeefefeffefefefefefefeefefeffefefefefefefeefefeffefefefefefefeefefeffefefefefefefeefefeffefefefefefefeefefeffefefefefefefeefefeffefefefefefefeefefeffefefefefefefeefefeffefefefefefefeefe',
        ),
      ],
      isLastPage: true,
      nextPageKey: pageKey + 1,
    );
  }

  /// 부상관리 상세 이동
  void _modeInjuryDetail({
    required DateTime recordDate,
  }) async {
    final args = IntensityDetailArgs(
      recordDate: recordDate,
    );
    final result =
        await Get.toNamed(RouteType.INTENSITY_DETAIL, arguments: args);
    if (result is bool && result) {
      onRefreshInjury();
    }
  }

  /// 부상관리 생성
  void recordInjury({required DateTime recordDate}) {
    _modeInjuryDetail(recordDate: recordDate);
  }

  /// 부상관리 수정
  void onPressedInjuryItem(HistoryInjuryItemUiState uiState) {
    // _modeInjuryDetail(recordDate: uiState.recordDate);
  }
}
