import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/urine_status_type.dart';
import 'package:physical_note/app/data/home/home_api.dart';
import 'package:physical_note/app/data/home/model/home_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/resources/strings/translations.dart';
import 'package:physical_note/app/ui/page/home2/home_ui_mapper.dart';
import 'package:physical_note/app/ui/page/home2/items/today_training/home_today_training_item_ui_state.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';
import 'package:physical_note/app/utils/getx/utils_getx.dart';

/// V2. Home 컨트롤러
class HomeController extends BaseController {
  @override
  void onReady() {
    _loadApi();
    super.onReady();
  }

  /// 오늘의 훈련 스크롤 컨트롤러
  final todayTrainingController = PageController();

  /// 오늘 훈련 목록
  final todayTrainingItems = <HomeTodayTrainingItemUiState>[].obs;

  /// 웰리니스 - 후퍼인덱스 - 평균
  final hooperIndexAverage = (null as int?).obs;

  /// 웰리니스 - 후퍼인덱스 - 수면의질
  final hooperIndexSleep = (null as int?).obs;

  /// 웰리니스 - 후퍼인덱스 - 스트레스
  final hooperIndexStress = (null as int?).obs;

  /// 웰리니스 - 후퍼인덱스 - 피로
  final hooperIndexFatigue = (null as int?).obs;

  /// 웰리니스 - 후퍼인덱스 - 근육통
  final hooperIndexMuscleSoreness = (null as int?).obs;

  /// 웰리니스 - 소변상태
  final urine = UrineStatusType.none.obs;

  /// 웰리니스 - 소변상태 - 설명
  final urineDescription = ''.obs;

  /// API - 홈 조회
  Future<void> _loadApi() async {
    setLoading(true);
    final homeApi = Get.find<HomeAPI>();
    final recordDate = DateTime.now().toFormattedString("yyyy-MM-dd");
    final response = await homeApi.getHome(recordDate);

    if (response is GetHomeResponseModel) {
      setScreen(response);
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
      setScreen(null);
    }

    setLoading(false);
  }
}
