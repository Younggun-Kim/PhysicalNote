import 'package:get/get.dart';
import 'package:physical_note/app/data/intensity/intensity_api.dart';
import 'package:physical_note/app/data/intensity/model/get_intensity_response_model.dart';
import 'package:physical_note/app/data/intensity/model/post_intensity_request_model.dart';
import 'package:physical_note/app/data/intensity/model/post_intensity_response_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/utils/utils.dart';

class IntensityNotiController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    _loadApi();
  }

  int physicalId = 0;

  final physicalSlider = 0.0.obs;

  final physicalTime = ''.obs;

  GetIntensityResponseModel? physicalData;

  int sportsId = 0;

  final sportsSlider = 0.0.obs;

  final sportsTime = ''.obs;

  GetIntensityResponseModel? sportsData;

  /// 피지컬 슬라이더 변경.
  void onPhysicalSliderChanged(double value) {
    physicalSlider.value = value.clamp(0, 10);
  }

  /// 피지컬 슬라이더 변경.
  void onSportsSliderChanged(double value) {
    sportsSlider.value = value.clamp(0, 10);
  }

  /// 저장 버튼 클릭.
  void onSaveBtnPressed({
    required bool isPhysicalUpdated,
    required bool isSportsUpdated,
  }) async {
    bool isUpdated = false;
    if (isPhysicalUpdated) {
      await putPhysical();
      isUpdated = true;
    }

    if (isSportsUpdated) {
      isUpdated = false;
      await putSport();
      isUpdated = true;
    }

    if (isUpdated) {
      close(result: true);
    }
  }

  /// 운동강도 - api 조회.
  Future _loadApi() async {
    final intensityApi = Get.find<IntensityAPI>();
    final date = DateTime.now().toFormattedString('yyyy-MM-dd');
    final response = await intensityApi.getIntensity(date);

    if (response is GetIntensityListResponseModel) {
      if (response.data?.isNotEmpty == true) {
        setPhysical(response.getPhysical());
        setSports(response.getSports());
      }
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
      setPhysical(null);
      setSports(null);
      physicalId = 0;
    }
  }

  void setPhysical(GetIntensityResponseModel? data) {
    physicalId = data?.id ?? 0;
    physicalSlider.value = data?.intensityType?.toDouble() ?? 0;
    physicalTime.value = removeZeroTimeUnits(
      data?.workoutTime?.toHourAndMinute() ?? '',
    );
    physicalData = data;
  }

  void setSports(GetIntensityResponseModel? data) {
    sportsId = data?.id ?? 0;
    sportsSlider.value = data?.intensityType?.toDouble() ?? 0;
    sportsTime.value = removeZeroTimeUnits(
      data?.workoutTime?.toHourAndMinute() ?? '',
    );
    sportsData = data;
  }

  // 0시간 또는 0분 제거
  String removeZeroTimeUnits(String time) {
    String tempTime = time;
    tempTime = tempTime.replaceAll('0시간 ', '');
    tempTime = tempTime.replaceAll(' 0분', '');
    return tempTime;
  }

  /// 운동 강도 수정.
  Future<void> _putIntensityDetail(
    PostIntensityRequestModel requestData,
    int intensityId,
  ) async {
    setLoading(true);
    final intensityApi = Get.find<IntensityAPI>();
    final response = await intensityApi.putIntensity(requestData, intensityId);

    if (response is PostIntensityResponseModel) {
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }
    await Future.delayed(const Duration(milliseconds: 500));
    setLoading(false);
  }

  Future putSport() async {
    final level = sportsSlider.value.toInt();
    if (sportsId <= 0 || level == 0 || sportsData == null) {
      return;
    }

    final requestData = sportsData!.toRequestModel().copyWith(
          intensityLevel: level,
        );

    await _putIntensityDetail(requestData, sportsId);
  }

  Future putPhysical() async {
    final level = physicalSlider.value.toInt();
    if (physicalId <= 0 || level == 0 || physicalData == null) {
      return;
    }

    final requestData = physicalData!.toRequestModel().copyWith(
          intensityLevel: level,
        );

    await _putIntensityDetail(requestData, physicalId);
  }
}
