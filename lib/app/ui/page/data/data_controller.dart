// ignore_for_file: unnecessary_cast

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/constants.dart';
import 'package:physical_note/app/config/constant/hooper_index_type.dart';
import 'package:physical_note/app/config/constant/workout_type.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/injury/injury_api.dart';
import 'package:physical_note/app/data/injury/model/get_injury_response_model.dart';
import 'package:physical_note/app/data/intensity/intensity_api.dart';
import 'package:physical_note/app/data/intensity/model/get_intensity_response_model.dart';
import 'package:physical_note/app/data/intensity/model/post_intensity_request_model.dart';
import 'package:physical_note/app/data/intensity/model/post_intensity_response_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/wellness/model/get_wellness_response_model.dart';
import 'package:physical_note/app/data/wellness/model/post_wellness_request_model.dart';
import 'package:physical_note/app/data/wellness/wellness_api.dart';
import 'package:physical_note/app/resources/strings/translations.dart';
import 'package:physical_note/app/ui/dialog/date_month_picker_dialog.dart';
import 'package:physical_note/app/ui/page/data/data_menu_type.dart';
import 'package:physical_note/app/ui/page/data/data_ui_mapper.dart';
import 'package:physical_note/app/ui/page/data/injury/injury_menu_type.dart';
import 'package:physical_note/app/ui/page/data/intensity/intensity_page_ui_state.dart';
import 'package:physical_note/app/ui/page/data/wellness/data_wellness_hooper_index_ui_state.dart';
import 'package:physical_note/app/ui/page/home/item/home_injury_check_item/home_injury_check_item_ui_state.dart';
import 'package:physical_note/app/ui/page/injury_check/injury_check_args.dart';
import 'package:physical_note/app/ui/page/main/main_screen.dart';
import 'package:physical_note/app/ui/widgets/custom_calendar/expansion_calendar_ui_state.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import 'injury/injury_state_type.dart';

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

  /// 웰리니스 Load 여부.
  var isLoadWellness = false;

  /// 운동강도 Load 여부.
  var isLoadIntensity = false;

  /// 부상체크 Load 여부.
  var isLoadInjury = false;

  /// 웰리니스 Id
  var wellnessId = (null as int?).obs;

  /// 웰리니스 - 후퍼인덱스 Ui State.
  var wellnessHooperIndexUiState = DataWellnessHooperIndexUiState().obs;

  /// 웰리니스 - 소변검사표.
  var wellnessUrineTable = 0.obs;

  /// 웰리니스 - 소변검사 몸무게.
  var wellnessUrineWeight = "".obsWithNumberController;

  /// 웰리니스 - 소변검사 Bmi.
  var wellnessUrineBmi = "".obsWithController;

  /// 이동할 탭.
  DataMenuType? willMoveTab;

  /// 스크롤 상단으로 이동.
  void scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  /// 날짜 싱크 맞추기.
  void syncDate(DateTime date) {
    calendarUiState.value.focusedDate = date;
    calendarUiState.refresh();

    /// 다시 로딩할 수 있게 초기화.
    isLoadWellness = false;
    isLoadIntensity = false;
    isLoadInjury = false;
  }

  /// 페이지 변경.
  void onChangedPage(int page) async {
    final menu = DataMenuType.fromPage(page);
    if (menu == DataMenuType.intensity) {
      await Future.delayed(const Duration(milliseconds: 500));
      updateIntensityWorkoutTime();
    }
  }

  /// 날짜 업데이트 요청.
  void _updateDate(DateTime date) {
    final mainController = Get.find<MainScreenController>();
    mainController.syncDate(date);
  }

  /// 날짜 변경.
  void onChangedDate(DateTime newDate) {
    _updateDate(newDate);
  }

  /// 년 클릭
  Future onPressedYear() async {
    final response = await Get.dialog(
      DateYearMonthPickerDialog(
        initialDate: calendarUiState.value.currentDate,
        minimumDate: Constants.CALENDAR_MIN_DATE,
        maximumDate: Constants.CALENDAR_MAX_DATE,
      ),
    );

    final newDateTime = response as DateTime?;

    if (newDateTime != null &&
        calendarUiState.value.focusedDate != newDateTime) {
      _updateDate(newDateTime);
    }
  }

  /// 달력 - 월 변경.
  void onPageChanged(DateTime newFocusDate) {
    _updateDate(newFocusDate);
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
    final newDate = DateTime(currentFocusedDate.year,
        currentFocusedDate.month - 1, currentFocusedDate.day);
    _updateDate(newDate);
  }

  /// 달력 - 다음 달 클릭.
  void onPressedCalendarNext() {
    final currentFocusedDate = calendarUiState.value.focusedDate;
    final newDate = DateTime(currentFocusedDate.year,
        currentFocusedDate.month + 1, currentFocusedDate.day);
    _updateDate(newDate);
  }

  /// 메뉴 선택.
  Future onTapMenu(DataMenuType newType) async {
    final oldMenuType = menu.value;
    menu.value = newType;

    /// 부상체크 서브 메뉴 열기/닫기.
    if (oldMenuType == newType) {
      var isOpen = isOpenInjuryMenu.value;
      isOpenInjuryMenu.value = !isOpen;
    }

    /// 운동강도 타임피커 초기화 버그 방지.
    if (newType != DataMenuType.intensity) {
      final isSport = intensityWorkoutType.value == WorkoutType.sports;
      final uiState = isSport
          ? intensitySportsUiState.value
          : intensityPhysicalUiState.value;
      final lastHour = uiState.hour;
      final lastMinute = uiState.minute;
      intensityHourController = FixedExtentScrollController(
        initialItem: lastHour,
      );
      intensityMinuteController = FixedExtentScrollController(
        initialItem: lastMinute,
      );
    }

    if (pageController.value.hasClients) {
      pageController.value.jumpToPage(newType.index);
      await loadApi();
    } else {
      /// 초기화가 다시.
      pageController.value = PageController(initialPage: newType.index);
      await loadApi();
    }
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
  void onChangedUrine(int value) {
    wellnessUrineTable.value = value;
  }

  /// 웰리니스 - 저장하기 클릭.
  Future<void> onPressedWellnessSave() async {
    final requestData = PostWellnessRequestModel(
      sleep: wellnessHooperIndexUiState.value.sleep.toInt(),
      stress: wellnessHooperIndexUiState.value.stress.toInt(),
      fatigue: wellnessHooperIndexUiState.value.fatigue.toInt(),
      muscleSoreness: wellnessHooperIndexUiState.value.muscleSoreness.toInt(),
      urine: wellnessUrineTable.value,
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
  Future loadApi() async {
    final currentMenu = menu.value;

    final canLoadApi = _canLoadApi();

    if (!canLoadApi) {
      return;
    }

    setLoading(true);
    switch (currentMenu) {
      case DataMenuType.wellness:
        await _loadWellness();
        isLoadWellness = true;
      case DataMenuType.intensity:
        await _loadIntensity();
        isLoadIntensity = true;
      case DataMenuType.injury:
        await _loadInjury();
        isLoadInjury = true;
    }

    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);
  }

  /// API Load 가능 여부 체크
  bool _canLoadApi() {
    final currentMenu = menu.value;
    switch (currentMenu) {
      case DataMenuType.wellness:
        return !isLoadWellness;
      case DataMenuType.intensity:
        return !isLoadIntensity;
      case DataMenuType.injury:
        return !isLoadInjury;
    }
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
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
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

  /**
   * 운동 강도 Intensity.
   */

  /// 운동 강도 - 스포츠 선택 여부.
  var intensityWorkoutType = (null as WorkoutType?).obs;

  /// 운동 강도 - UiState
  var intensityUiState = (null as IntensityPageUiState?).obs;

  /// 운동 강도 - 시간 컨트롤러.
  var intensityHourController = FixedExtentScrollController(
    initialItem: 0,
  );

  /// 운동 강도 - 분 컨트롤러.
  var intensityMinuteController = FixedExtentScrollController(
    initialItem: 0,
  );

  /// 운동강도 - 타임피커 enabled
  late var intensityTimePickerEnabled = intensityWorkoutType.behaviorStream
      .map((event) => event != null)
      .toObs(false);

  /// 운동 강도 - 스포츠 Ui State.
  final intensitySportsUiState =
      IntensityPageUiState(type: WorkoutType.sports).obs;

  /// 운동 강도 - 피지컬 Ui State.
  final intensityPhysicalUiState =
      IntensityPageUiState(type: WorkoutType.physical).obs;

  /// 운동강도 - 현재 선택된 Ui State
  late final intensityCurrentUiState =
      CombineLatestStream<dynamic, IntensityPageUiState?>([
    intensityWorkoutType.behaviorStream,
    intensitySportsUiState.behaviorStream,
    intensityPhysicalUiState.behaviorStream,
  ], (values) {
    logger.i('change state');
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
  }).toObs(null as IntensityPageUiState?);

  /// 운동 강도 - 종류 선택.
  void onPressedWorkout(WorkoutType type) {
    intensityWorkoutType.value = type;
    updateIntensityWorkoutTime();
  }

  /// 운동 강도 - 시간 변경.
  void onSelectedHourChanged(int value) {
    final type = intensityWorkoutType.value;
    if (type == WorkoutType.sports) {
      intensitySportsUiState.value.hour = value;
    } else if (type == WorkoutType.physical) {
      intensityPhysicalUiState.value.hour = value;
    } else {}

    updateIntensityUiState();
  }

  /// 운동 강도 - 시간 변경.
  void onSelectedMinChanged(int value) {
    final type = intensityWorkoutType.value;
    if (type == WorkoutType.sports) {
      intensitySportsUiState.value.minute = value;
    } else if (type == WorkoutType.physical) {
      intensityPhysicalUiState.value.minute = value;
    } else {}

    updateIntensityUiState();
  }

  /// 운동강도 - 레벨 선택.
  void onPressedLevel(int level) {
    logger.i('onPressedLevel : $level');
    final type = intensityWorkoutType.value;
    if (type == WorkoutType.sports) {
      intensitySportsUiState.value.level = level;
    } else if (type == WorkoutType.physical) {
      intensityPhysicalUiState.value.level = level;
    } else {
      showToast("운동 종류를 선택해주세요.");
    }
    updateIntensityUiState();
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
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
      setIntensity(null); // 값 초기화
    }
  }

  void updateIntensityWorkoutTime() {
    final type = intensityWorkoutType.value;

    /// 시간 설정.
    if (type == WorkoutType.sports) {
      intensityHourController.jumpToItem(intensitySportsUiState.value.hour);
      intensityMinuteController.jumpToItem(intensitySportsUiState.value.minute);
    } else if (type == WorkoutType.physical) {
      intensityHourController.jumpToItem(intensityPhysicalUiState.value.hour);
      intensityMinuteController
          .jumpToItem(intensityPhysicalUiState.value.minute);
    } else {}
  }

  /// 운동 강도 저장 버튼 클릭.
  Future<void> onPressedSaveButton() async {
    final type = intensityWorkoutType.value;

    if (type == null) {
      showToast("운동을 선택해주세요.");
      return;
    }

    final level = type == WorkoutType.sports
        ? intensitySportsUiState.value.level
        : intensityPhysicalUiState.value.level;
    final time = type == WorkoutType.sports
        ? intensitySportsUiState.value.time
        : intensityPhysicalUiState.value.time;
    final intensityId = type == WorkoutType.sports
        ? intensitySportsUiState.value.id
        : intensityPhysicalUiState.value.id;

    final requestData = PostIntensityRequestModel(
      intensityLevel: level,
      workoutTime: time,
      workoutType: type.remote,
      recordDate:
          calendarUiState.value.focusedDate.toFormattedString("yyyy-MM-dd"),
    );

    if (intensityId == null) {
      _postIntensity(requestData);
    } else {
      _putIntensityDetail(requestData, intensityId);
    }
  }

  /// 운동 강도 저장.
  Future<void> _postIntensity(PostIntensityRequestModel requestData) async {
    setLoading(true);
    final intensityApi = Get.find<IntensityAPI>();
    final response = await intensityApi.postIntensity(requestData);

    if (response is PostIntensityResponseModel) {
      showToast("운동 강도 저장 성공.");
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
      showToast("운동 강도 저장 성공.");
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }
    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);
  }

  /// 운동 강도 Ui State refresh
  void updateIntensityUiState() {
    intensitySportsUiState.refresh();
    intensityPhysicalUiState.refresh();
    intensityCurrentUiState.refresh();
  }

  // ignore: slash_for_doc_comments
  /**
   * 부상체크
   */

  late var injuryList = <HomeInjuryCheckItemUiState>[].obs
    ..listen((p0) {
      _setHumanMuscleColor();
    });

  var injuryDetailId = (null as int?).obs;

  var isOpenInjuryMenu = false.obs;

  var currentInjuryMenu = InjuryMenuType.check.obs;

  var injuryStateType = InjuryStateType.progress.obs;

  var _humanFrontOriginImage = "";

  var _humanBackOriginImage = "";

  final humanFrontImage = "".obs;

  final humanBackImage = "".obs;

  /// 부상 체크 메뉴 선택.
  void onPressedInjuryMenu(InjuryMenuType type) {
    currentInjuryMenu.value = type;
    isOpenInjuryMenu.value = false;
  }

  /// 부상 상태 타입 버튼 클릭
  void onPressedInjuryStateType(InjuryStateType type) {
    injuryStateType.value = type;
  }

  /// 부상체크 조회.
  Future _loadInjury() async {
    final injuryApi = Get.find<InjuryAPI>();
    final date =
        calendarUiState.value.focusedDate.toFormattedString('yyyy-MM-dd');
    final response = await injuryApi.getInjury(recordDate: date);

    if (response is GetInjuryResponseModel) {
      setInjury(response);
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
      setInjury(null); // 값 초기화
    }
  }

  /// 사람 근육 이미지 로딩.
  void initHumanMuscleImage(String frontImage, String backImage) {
    _humanFrontOriginImage = frontImage;
    _humanBackOriginImage = backImage;

    humanFrontImage.value = _humanFrontOriginImage;
    humanBackImage.value = _humanBackOriginImage;
  }

  /// 사람 근육 선택
  void _setHumanMuscleColor() {
    humanFrontImage.value = MuscleUtils.setHumanMuscleColor(
      injuryList.toList(),
      // TestUtils.humanFrontList,
      _humanFrontOriginImage,
      true,
    );

    humanBackImage.value = MuscleUtils.setHumanMuscleColor(
      injuryList.toList(),
      // TestUtils.humanBackList,
      _humanBackOriginImage,
      false,
    );
  }

  /// 부상체크 추가 클릭.
  void onPressedAdd() async {
    await _moveInjuryDetail(null);
  }

  /// 부상 체크 편집 클릭.
  void onPressedEdit(HomeInjuryCheckItemUiState uiState) async {
    await _moveInjuryDetail(uiState.id);
  }

  /// 부상 체크 상세로 이동.
  Future _moveInjuryDetail(int? injuryId) async {
    final args =
        InjuryCheckArgs(date: calendarUiState.value.focusedDate, id: injuryId);
    final result = await Get.toNamed(RouteType.INJURY_CHECK, arguments: args);
    if (result is bool && result == true) {
      isLoadInjury = false;
      loadApi();
    }
  }
}
