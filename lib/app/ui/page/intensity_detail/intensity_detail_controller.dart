import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/workout_type.dart';
import 'package:physical_note/app/data/intensity/intensity_api.dart';
import 'package:physical_note/app/data/intensity/model/get_intensity_response_model.dart';
import 'package:physical_note/app/data/intensity/model/post_intensity_request_model.dart';
import 'package:physical_note/app/data/intensity/model/post_intensity_response_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/dialog/clanedar_dialog/calendar_dialog.dart';
import 'package:physical_note/app/ui/page/intensity_detail/intensity_detail.dart';
import 'package:physical_note/app/ui/page/intensity_detail/intensity_detail_ui_state.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

/// 운동강도 등록/수정 컨트롤러
///
/// 등록/수정 성공시 true 리턴
class IntensityDetailController extends BaseController {
  final args = Get.arguments as IntensityDetailArgs;

  /// 기록 날짜
  late final recordDate = args.recordDate.obs;

  /// 운동 타입.
  final _workoutType = (null as WorkoutType?).obs;

  /// 운동 타입 - 스포츠 여부
  late final isSport = _workoutType.behaviorStream
      .map((e) => e == WorkoutType.sports)
      .toObs(false);

  /// 운동 타입 - 피지컬 여부
  late final isPhysical = _workoutType.behaviorStream
      .map((e) => e == WorkoutType.physical)
      .toObs(false);

  /// 운동 강도 - 시간 컨트롤러.
  var hourController = FixedExtentScrollController(
    initialItem: 0,
  );

  /// 운동 강도 - 분 컨트롤러.
  var minuteController = FixedExtentScrollController(
    initialItem: 0,
  );

  /// 운동 강도 - 스포츠 Ui State.
  final _sportUiState = IntensityDetailUiState(type: WorkoutType.sports).obs;

  /// 운동 강도 - 피지컬 Ui State.
  final _physicalUiState =
      IntensityDetailUiState(type: WorkoutType.physical).obs;

  /// 운동강도 - 현재 선택된 Ui State
  late final currentUiState =
      CombineLatestStream<dynamic, IntensityDetailUiState?>([
    _workoutType.behaviorStream,
    _sportUiState.behaviorStream,
    _physicalUiState.behaviorStream,
  ], (values) {
    final workoutType = values[0];
    final sportsUiState = values[1];
    final physicalUiState = values[2];
    if (workoutType == WorkoutType.sports) {
      return sportsUiState;
    } else if (workoutType == WorkoutType.physical) {
      return physicalUiState;
    } else {
      return null;
    }
  }).toObs(null as IntensityDetailUiState?);

  /// 운동강도 - 타임피커 enabled
  late final timePickerEnabled = _workoutType.behaviorStream
      .map(
        (event) => event != null,
      )
      .toObs(false);

  /**
   * LifeCycle
   */

  /// OnReady
  @override
  void onReady() {
    super.onReady();
    _loadApi();
  }

  /**
   * 메소드
   */

  /// 운동 타입 업데이트
  void updateWorkoutType(WorkoutType type) {
    _workoutType.value = type;
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
      _loadApi();
    }
  }

  /// 운동 강도 - 종류 선택.
  void onPressedType(WorkoutType type) {
    _workoutType.value = type;
    _updateWorkoutTime();
  }

  /// 운동 시간 업데이트
  void _updateWorkoutTime() {
    final type = _workoutType.value;

    /// 시간 설정.
    if (type == WorkoutType.sports) {
      hourController.jumpToItem(_sportUiState.value.hour);
      minuteController.jumpToItem(_sportUiState.value.minute);
    } else if (type == WorkoutType.physical) {
      hourController.jumpToItem(_physicalUiState.value.hour);
      minuteController.jumpToItem(_physicalUiState.value.minute);
    } else {}
  }

  /// 운동 강도 Ui State refresh
  void _updateUiState() {
    _sportUiState.refresh();
    _physicalUiState.refresh();
    currentUiState.refresh();
  }

  /// 운동 강도 - 시간 변경.
  void onSelectedHourChanged(int value) {
    if (isSport.value) {
      _sportUiState.value.hour = value;
    } else if (isPhysical.value) {
      _physicalUiState.value.hour = value;
    } else {}

    _updateUiState();
  }

  /// 운동 강도 - 시간 변경.
  void onSelectedMinChanged(int value) {
    if (isSport.value) {
      _sportUiState.value.minute = value;
    } else if (isPhysical.value) {
      _physicalUiState.value.minute = value;
    } else {}

    _updateUiState();
  }

  /// 운동강도 - 레벨 선택.
  void onPressedLevel(int level) {
    if (isSport.value) {
      _sportUiState.value.level = level;
    } else if (isPhysical.value) {
      _physicalUiState.value.level = level;
    } else {
      showToast(StringRes.pleaseChooseWorkout.tr);
    }
    _updateUiState();
  }

  /// 운동 강도 저장 버튼 클릭.
  Future<void> onPressedSaveButton() async {
    final uiState = currentUiState.value;
    if (uiState == null) {
      showToast(StringRes.pleaseChooseWorkout.tr);
      return;
    }

    final intensityId = uiState.id;
    final level = uiState.level;
    final time = uiState.time;
    final date = recordDate.value.toFormattedString('yyyy-MM-dd');

    final requestData = PostIntensityRequestModel(
      intensityLevel: level,
      workoutTime: time,
      workoutType: uiState.type.remote,
      recordDate: date,
    );

    if (intensityId == null) {
      _postIntensity(requestData);
    } else {
      _putIntensityDetail(requestData, intensityId);
    }
  }

  /// 운동강도 - api 조회.
  Future _loadApi() async {
    final intensityApi = Get.find<IntensityAPI>();
    final date = recordDate.value.toFormattedString('yyyy-MM-dd');
    final response = await intensityApi.getIntensity(date);

    if (response is GetIntensityListResponseModel) {
      _setIntensity(response);
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
      _setIntensity(null); // 값 초기화
    }
  }

  /// 운동 강도 저장.
  Future<void> _postIntensity(PostIntensityRequestModel requestData) async {
    setLoading(true);
    final intensityApi = Get.find<IntensityAPI>();
    final response = await intensityApi.postIntensity(requestData);

    if (response is PostIntensityResponseModel) {
      showToast(StringRes.intensitySaveSuccessful.tr);
      await Future.delayed(const Duration(seconds: 1));
      close(result: true);
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }
    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);
  }

  /// 운동 강도 수정.
  Future<void> _putIntensityDetail(
      PostIntensityRequestModel requestData, int intensityId) async {
    setLoading(true);
    final intensityApi = Get.find<IntensityAPI>();
    final response = await intensityApi.putIntensity(requestData, intensityId);

    if (response is PostIntensityResponseModel) {
      showToast(StringRes.intensitySaveSuccessful.tr);
      await Future.delayed(const Duration(seconds: 1));
      close(result: true);
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }
    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);
  }

  /// UI Mapper 역할
  void _setIntensity(GetIntensityListResponseModel? list) {
    final data = list?.data;
    if (data == null) {
      hourController.jumpToItem(0);
      minuteController.jumpToItem(0);
      _workoutType.value = null;
    } else {
      final sportsData = data.firstWhereOrNull(
        (e) => e.workoutType == WorkoutType.sports.remote,
      );
      final physicalData = data.firstWhereOrNull(
        (e) => e.workoutType == WorkoutType.physical.remote,
      );

      if (sportsData != null) {
        _workoutType.value = WorkoutType.sports;
      } else if (physicalData != null) {
        _workoutType.value = WorkoutType.physical;
      } else {
        _workoutType.value = WorkoutType.sports;
      }

      var sportUiState = _sportUiState.value;
      sportUiState.id = sportsData?.id;
      sportUiState.level = sportsData?.intensityType;
      sportUiState.hour = _convertTimeToHour(sportsData?.workoutTime);
      sportUiState.minute = _convertTimeToMinute(sportsData?.workoutTime);
      _sportUiState.value = sportUiState;

      var physicalUiState = _physicalUiState.value;
      physicalUiState.id = physicalData?.id;
      physicalUiState.level = physicalData?.intensityType;
      physicalUiState.hour = _convertTimeToHour(physicalData?.workoutTime);
      physicalUiState.minute = _convertTimeToMinute(physicalData?.workoutTime);
      _physicalUiState.value = physicalUiState;

      /// 재선택 처리.
      _workoutType.refresh();
      _updateUiState();
      _updateWorkoutTime();
    }
  }

  /// HH:mm:ss의 시간 가져오기
  int _convertTimeToHour(String? time) {
    final splitTime = time?.split(":");
    if (splitTime != null && splitTime.isNotEmpty && splitTime.length == 3) {
      return int.tryParse(splitTime.first.toString()) ?? 0;
    } else {
      return 0;
    }
  }

  /// HH:mm:ss의 분 가져오기
  int _convertTimeToMinute(String? time) {
    final splitTime = time?.split(":");
    if (splitTime != null && splitTime.isNotEmpty && splitTime.length == 3) {
      return int.tryParse(splitTime[1].toString()) ?? 0;
    } else {
      return 0;
    }
  }
}
