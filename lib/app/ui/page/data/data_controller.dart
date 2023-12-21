import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/app_constant.dart';
import 'package:physical_note/app/config/constant/hooper_index_type.dart';
import 'package:physical_note/app/data/wellness/model/post_wellness_request_model.dart';
import 'package:physical_note/app/data/wellness/wellness_api.dart';
import 'package:physical_note/app/ui/dialog/date_month_picker_dialog.dart';
import 'package:physical_note/app/ui/page/data/data_menu_type.dart';
import 'package:physical_note/app/ui/page/data/data_ui_mapper.dart';
import 'package:physical_note/app/ui/page/data/wellness/data_wellness_hooper_index_ui_state.dart';
import 'package:physical_note/app/ui/widgets/custom_calendar/expansion_calendar_ui_state.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';
import 'package:physical_note/app/utils/utils.dart';

// TODO: 키보드 버그 수정, 스크롤뷰 클릭시 키보드 내려가게, API 저장 후 리스펀스로 세팅하는거 없애기.
// TODO: isWellnessLoaded 로 Post, Put 나누기,
class DataController extends BaseController {
  /// 스크롤 컨트롤러.
  final scrollController = ScrollController();

  /// 페이지 컨트롤러.
  var pageController = PageController(initialPage: 0).obs;

  /// 캘린더 Ui State.
  late var calendarUiState = ExpansionCalendarUiState(
    isExpanded: true,
    currentDate: DateTime.now(),
    focusedDate: DateTime.now(),
  ).obs;

  /// 메뉴.
  var menu = DataMenuType.wellness.obs;

  /// 웰리니스 Api 로딩 여부.
  var isWellnessLoaded = false.obs;

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
  void onPressedWellnessSave() {
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
    _postWellness(requestData);
  }

  /// 화면 정보 로딩.
  Future _loadApi() async {
    final currentMenu = menu.value;

    setLoading(true);
    switch (currentMenu) {
      case DataMenuType.wellness:
        await _loadWellness();
      case DataMenuType.intensity:
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

    isWellnessLoaded.value = response?.id != null;
    setWellness(response);
  }

  /// 웰리니스 저장하기.
  Future<void> _postWellness(PostWellnessRequestModel requestData) async {
    final wellnessApi = Get.find<WellnessAPI>();

    setLoading(true);
    final response = await wellnessApi.postWellness(requestData: requestData);
    isWellnessLoaded.value = response?.id != null;
    logger.w("response: ${response?.toJson()}");
    setWellness(response);
    await Future.delayed(const Duration(seconds: 1));
    setLoading(false);
  }
}
