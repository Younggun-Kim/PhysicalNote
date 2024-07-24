import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/hooper_index_type.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/wellness/model/get_wellness_response_model.dart';
import 'package:physical_note/app/data/wellness/model/post_wellness_request_model.dart';
import 'package:physical_note/app/data/wellness/wellness_api.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/dialog/clanedar_dialog/calendar_dialog.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'item/hooper_index_ui_state.dart';
import 'wellness_detail_args.dart';

// TODO: 상세 조회 API 추가
// TODO: FCM 이동 추가
class WellnessDetailController extends BaseController {
  final args = Get.arguments as WellnessDetailArgs;

  /// 웰리니스 Id
  late final wellnessId = args.wellnessId.obs;

  /// 기록 날짜
  // TODO: args에서 받도록 변경하기
  final recordDate = DateTime.now().obs;

  /// 후퍼인덱스.
  final hooperIndexUiState = HooperIndexUiState().obs;

  /// 소변검사표
  final urineTable = 0.obs;

  /// 웰리니스 - 소변검사 몸무게.
  final urineWeight = "".obsWithNumberController;

  /// 웰리니스 - 소변검사 Bmi.
  final urineBmi = "".obsWithController;

  /**
   * Methods
   */

  /// 웰리니스란 클릭
  void onTapWellnessGuideButton() {}

  /// 후퍼인덱스 슬라이드 값 변경
  void onChangeHooperIndex(HooperIndexType type, double value) {
    switch (type) {
      case HooperIndexType.sleep:
        hooperIndexUiState.value.sleep = value;
      case HooperIndexType.stress:
        hooperIndexUiState.value.stress = value;
      case HooperIndexType.fatigue:
        hooperIndexUiState.value.fatigue = value;
      case HooperIndexType.muscleSoreness:
        hooperIndexUiState.value.muscleSoreness = value;
    }
    hooperIndexUiState.refresh();
  }

  /// 소변검사 슬라이드 변경 이벤트.
  void onChangedUrine(int value) {
    urineTable.value = value;
  }


  /// 달력 클릭.
  Future<void> onPressedCalendar() async {
    final response = await Get.dialog(
      CalendarDialog(
        currentDate: recordDate.value,
        focusedDate: recordDate.value,
      ),
    );

    final newDateTime = response as DateTime?;

    if (newDateTime != null) {
      recordDate.value = newDateTime;
    }
  }

  /// 웰리니스 - 저장하기 클릭.
  Future<void> onPressedSave() async {
    final requestData = PostWellnessRequestModel(
      sleep: hooperIndexUiState.value.sleep.toInt(),
      stress: hooperIndexUiState.value.stress.toInt(),
      fatigue: hooperIndexUiState.value.fatigue.toInt(),
      muscleSoreness: hooperIndexUiState.value.muscleSoreness.toInt(),
      urine: urineTable.value,
      bodyFat: double.tryParse(urineBmi.value) ?? 0.0,
      emptyStomachWeight: double.tryParse(urineWeight.value) ?? 0.0,
      recordDate: '',
    );

    logger.w("requestData: ${requestData.toJson()}");

    final id = wellnessId.value;
    if (id == null) {
      _postWellness(requestData);
    } else {
      _putWellnessDetail(id, requestData);
    }
  }

  /// 웰리니스 저장하기.
  Future<void> _postWellness(PostWellnessRequestModel requestData) async {
    final wellnessApi = Get.find<WellnessAPI>();

    setLoading(true);
    final response = await wellnessApi.postWellness(requestData: requestData);

    if (response is GetWellnessResponseModel) {
      wellnessId.value = response.id;
      showToast("웰리니스 저장 성공.");
    } else {
      wellnessId.value = null;
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }
    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);
  }

  /// 웰리니스 수정하기.
  Future<void> _putWellnessDetail(
      int id, PostWellnessRequestModel requestData) async {
    final wellnessApi = Get.find<WellnessAPI>();

    setLoading(true);

    final response = await wellnessApi.putWellnessDetail(
      wellnessId: id,
      requestData: requestData,
    );

    if (response is GetWellnessResponseModel) {
      wellnessId.value = response.id;
      showToast("웰리니스 수정 성공.");
    } else {
      wellnessId.value = null;
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }
    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);
  }
}
