// ignore_for_file: unnecessary_cast

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/app_constant.dart';
import 'package:physical_note/app/config/constant/hooper_index_type.dart';
import 'package:physical_note/app/config/constant/workout_type.dart';
import 'package:physical_note/app/data/intensity/intensity_api.dart';
import 'package:physical_note/app/data/intensity/model/get_intensity_response_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/wellness/model/get_wellness_response_model.dart';
import 'package:physical_note/app/data/wellness/model/post_wellness_request_model.dart';
import 'package:physical_note/app/data/wellness/wellness_api.dart';
import 'package:physical_note/app/ui/dialog/date_month_picker_dialog.dart';
import 'package:physical_note/app/ui/page/data/data_menu_type.dart';
import 'package:physical_note/app/ui/page/data/data_ui_mapper.dart';
import 'package:physical_note/app/ui/page/data/intensity/intensity_page_ui_state.dart';
import 'package:physical_note/app/ui/page/data/wellness/data_wellness_hooper_index_ui_state.dart';
import 'package:physical_note/app/ui/widgets/custom_calendar/expansion_calendar_ui_state.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';
import 'package:physical_note/app/utils/utils.dart';

class DataController extends BaseController {
  /// 스크롤 컨트롤러.
  final scrollController = ScrollController();

  /// 페이지 컨트롤러.
  var pageController = PageController(initialPage: 0).obs;

  /// 캘린더 Ui State.
  late var calendarUiState = ExpansionCalendarUiState(
    isExpanded: false,
    currentDate: DateTime.now(),
    focusedDate: DateTime.now(),
  ).obs;

  /// 메뉴.
  var menu = DataMenuType.wellness.obs;

  /// 웰리니스 Id
  var wellnessId = (null as int?).obs;

  /// 웰리니스 - 후퍼인덱스 Ui State.
  var wellnessHooperIndexUiState = DataWellnessHooperIndexUiState().obs;

  /// 웰리니스 - 소변검사표.
  var wellnessUrineTable = 1.0.obs;

  /// 웰리니스 - 소변검사 몸무게.
  var wellnessUrineWeight = "".obsWithController;

  /// 웰리니스 - 소변검사 Bmi.
  var wellnessUrineBmi = "".obsWithController;

  /// 스크롤 상단으로 이동.
  void scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  /// 날짜 변경.
  void onChangedDate(DateTime newDate) {
    calendarUiState.value.focusedDate = newDate;
    calendarUiState.refresh();

    _loadApi();
  }

  /// 년 클릭
  Future onPressedYear() async {
    final response = await Get.dialog(
      DateYearMonthPickerDialog(
        initialDate: calendarUiState.value.currentDate,
        minimumDate: AppConstant.CALENDAR_MIN_DATE,
        maximumDate: AppConstant.CALENDAR_MAX_DATE,
      ),
    );

    final newDateTime = response as DateTime?;

    if (newDateTime != null &&
        calendarUiState.value.focusedDate != newDateTime) {
      onChangedDate(newDateTime);
    }
  }

  /// 달력 - 월 변경.
  void onPageChanged(DateTime newFocusDate) {
    calendarUiState.value.focusedDate = newFocusDate;
    calendarUiState.refresh();
  }

  /// 달력 - 폴딩
  void onToggleCalendarExpanded() {
    final isExpanded = !calendarUiState.value.isExpanded;
    calendarUiState.value.isExpanded = isExpanded;
    calendarUiState.refresh();
  }

  /// 달력 - 이전 달 클릭.
  void onPressedCalendarPrev() {
    final currentFocusedDate = calendarUiState.value.focusedDate;
    calendarUiState.value.focusedDate = DateTime(currentFocusedDate.year,
        currentFocusedDate.month - 1, currentFocusedDate.day);
    calendarUiState.refresh();
  }

  /// 달력 - 다음 달 클릭.
  void onPressedCalendarNext() {
    final currentFocusedDate = calendarUiState.value.focusedDate;
    calendarUiState.value.focusedDate = DateTime(currentFocusedDate.year,
        currentFocusedDate.month + 1, currentFocusedDate.day);
    calendarUiState.refresh();
  }

  /// 메뉴 선택.
  void onTapMenu(DataMenuType type) {
    menu.value = type;
    pageController.value.jumpToPage(type.index);
  }

  /// 웰리니스 - 후퍼인덱스 슬라이드 변경 이벤트.
  void onChangeHooperIndex(HooperIndexType type, double value) {
    switch (type) {
      case HooperIndexType.sleep:
        wellnessHooperIndexUiState.value.sleep = value;

      case HooperIndexType.stress:
        wellnessHooperIndexUiState.value.stress = value;
      case HooperIndexType.fatigue:
        wellnessHooperIndexUiState.value.fatigue = value;
      case HooperIndexType.muscleSoreness:
        wellnessHooperIndexUiState.value.muscleSoreness = value;
    }
    wellnessHooperIndexUiState.refresh();
  }

  /// 웰리니스 - 소변검사 슬라이드 변경 이벤트.
  void onChangedUrine(double value) {
    wellnessUrineTable.value = value;
  }

  /// 웰리니스 - 저장하기 클릭.

  Future<void> onPressedWellnessSave() async {
    final requestData = PostWellnessRequestModel(
      sleep: wellnessHooperIndexUiState.value.sleep.toInt(),
      stress: wellnessHooperIndexUiState.value.stress.toInt(),
      fatigue: wellnessHooperIndexUiState.value.fatigue.toInt(),
      muscleSoreness: wellnessHooperIndexUiState.value.muscleSoreness.toInt(),
      urine: wellnessUrineTable.value.toInt(),
      bodyFat: double.tryParse(wellnessUrineBmi.value) ?? 0.0,
      emptyStomachWeight: double.tryParse(wellnessUrineWeight.value) ?? 0.0,
      recordDate:
          calendarUiState.value.focusedDate.toFormattedString("yyyy-MM-dd"),
    );

    logger.w("requestData: ${requestData.toJson()}");

    final id = wellnessId.value;
    if (id == null) {
      _postWellness(requestData);
    } else {
      _putWellnessDetail(id, requestData);
    }
  }

  /// 화면 정보 로딩.
  Future _loadApi() async {
    final currentMenu = menu.value;

    setLoading(true);
    switch (currentMenu) {
      case DataMenuType.wellness:
        await _loadWellness();
      case DataMenuType.intensity:
        await _loadIntensity();
        break;
      case DataMenuType.injury:
        break;
    }

    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);
  }

  /// 웰리니스 불러오기.
  Future<void> _loadWellness() async {
    final wellnessApi = Get.find<WellnessAPI>();
    final date =
        calendarUiState.value.focusedDate.toFormattedString('yyyy-MM-dd');
    final response = await wellnessApi.getWellness(date);

    if (response is GetWellnessResponseModel) {
      wellnessId.value = response.id;
      setWellness(response);
    } else {
      wellnessId.value = null;
      final message =
          (response as ServerResponseFailModel?)?.devMessage ?? "서버 에러";
      showToast(message);
      setWellness(null); // 값 초기화
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
      final message =
          (response as ServerResponseFailModel?)?.devMessage ?? "서버 에러";
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
      final message =
          (response as ServerResponseFailModel?)?.devMessage ?? "서버 에러";
      showToast(message);
    }
    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);
  }

  /**
   * 운동 강도 Intensity.
   */

  /// 운동 강도 - 스포츠 선택 여부.
  var intensityWorkoutType = (null as WorkoutType?).obs;

  /// 운동 강도 - UiState
  IntensityPageUiState? get intensityUiState => _getIntensityUiState();

  IntensityPageUiState? _getIntensityUiState() {
    final type = intensityWorkoutType.value;
    if (type == WorkoutType.sports) {
      return _intensitySportsUiState.value;
    } else if (type == WorkoutType.physical) {
      return _intensityPhysicalUiState.value;
    } else {
      return null;
    }
  }

  /// 운동 강도 - 시간 컨트롤러.
  final intensityHourController = FixedExtentScrollController(
    initialItem: 0,
  );

  /// 운동 강도 - 분 컨트롤러.
  final intensityMinuteController = FixedExtentScrollController(
    initialItem: 0,
  );

  /// 운동 강도 - 스포츠 Ui State.
  final _intensitySportsUiState =
      IntensityPageUiState(type: WorkoutType.sports).obs;

  /// 운동 강도 - 피지컬 Ui State.
  final _intensityPhysicalUiState =
      IntensityPageUiState(type: WorkoutType.physical).obs;

  /// 운동 강도 - 종류 선택.
  void onPressedWorkout(WorkoutType type) {
    intensityWorkoutType.value = type;

    /// 시간 설정.
    if (type == WorkoutType.sports) {
      intensityHourController.jumpToItem(_intensitySportsUiState.value.hour);
      intensityMinuteController
          .jumpToItem(_intensitySportsUiState.value.minute);
    } else if (type == WorkoutType.physical) {
      intensityHourController.jumpToItem(_intensityPhysicalUiState.value.hour);
      intensityMinuteController
          .jumpToItem(_intensityPhysicalUiState.value.minute);
    } else {}
  }

  /// 운동 강도 - 시간 변경.
  void onSelectedHourChanged(int value) {
    final type = intensityWorkoutType.value;
    if (type == WorkoutType.sports) {
      _intensitySportsUiState.value.hour = value;
      _intensityPhysicalUiState.refresh();
    } else if (type == WorkoutType.physical) {
      _intensityPhysicalUiState.value.hour = value;
      _intensityPhysicalUiState.refresh();
    } else {}
  }

  /// 운동 강도 - 시간 변경.
  void onSelectedMinChanged(int value) {
    final type = intensityWorkoutType.value;
    if (type == WorkoutType.sports) {
      _intensitySportsUiState.value.minute = value;
      _intensityPhysicalUiState.refresh();
    } else if (type == WorkoutType.physical) {
      _intensityPhysicalUiState.value.minute = value;
      _intensityPhysicalUiState.refresh();
    } else {}
  }

  /// 운동강도 - 레벨 선택.
  void onPressedLevel(int level) {
    final type = intensityWorkoutType.value;
    if (type == WorkoutType.sports) {
      _intensitySportsUiState.value.level = level;
      _intensityPhysicalUiState.refresh();
    } else if (type == WorkoutType.physical) {
      _intensityPhysicalUiState.value.level = level;
      _intensityPhysicalUiState.refresh();
    } else {
      showToast("운동 종류를 선택해주세요.");
    }
  }

  /// 운동강도 - api 조회.
  Future _loadIntensity() async {
    final intensityApi = Get.find<IntensityAPI>();
    final date =
        calendarUiState.value.focusedDate.toFormattedString('yyyy-MM-dd');
    final response = await intensityApi.getIntensity(date);

    if (response is GetIntensityListResponseModel) {
      setIntensity(response);
    } else {
      final message =
          (response as ServerResponseFailModel?)?.devMessage ?? "서버 에러";
      showToast(message);
      setIntensity(null); // 값 초기화
    }
  }
}
