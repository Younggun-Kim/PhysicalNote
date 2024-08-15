import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/dialog/history_filter/history_filter_dialog.dart';
import 'package:physical_note/app/ui/dialog/history_filter/history_filter_dialog_args.dart';
import 'package:physical_note/app/ui/page/history/history_tab_manager.dart';
import 'package:physical_note/app/ui/page/history/injury/history_injury_controller.dart';
import 'package:physical_note/app/ui/page/history/type/history_order_filter_type.dart';
import 'package:physical_note/app/ui/page/history/type/history_tab_type.dart';
import 'package:physical_note/app/ui/page/history/wellness/history_wellness_controller.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'intensity/history_intensity_controller.dart';
import 'type/history_date_filter_type.dart';

class HistoryController extends BaseController
    with
        GetSingleTickerProviderStateMixin,
        HistoryWellnessController,
        HistoryIntensityController,
        HistoryInjuryController {
  late final HistoryTabManager _tabManager;

  TabController get tabController => _tabController;

  late final TabController _tabController;

  final scrollController = ScrollController();

  /// 기록날짜
  DateTime recordDate = DateTime.now();

  /// 날짜 필터
  @override
  final dateFilter = HistoryDateFilterType.all.obs;

  /// 각 탭의 날짜 필터
  final _tabDateFilter = <HistoryDateFilterType>[
    HistoryDateFilterType.all,
    HistoryDateFilterType.all,
    HistoryDateFilterType.all,
  ].obs;

  /// 순서 필터
  @override
  final orderFilter = HistoryOrderFilterType.asc.obs;

  /// 각 탭의 날짜 필터
  final _tabOrderFilter = <HistoryOrderFilterType>[
    HistoryOrderFilterType.asc,
    HistoryOrderFilterType.asc,
    HistoryOrderFilterType.asc,
  ].obs;

  @override
  final isRecovery = (null as bool?).obs;

  /// LifeCycle
  @override
  void onInit() {
    _tabController = TabController(
      initialIndex: 0,
      length: HistoryTabType.values.length,
      vsync: this,
    );
    _tabManager = HistoryTabManager(_tabController);
    super.onInit();
  }

  @override
  onClose() {
    _tabController.dispose();
  }

  /// MainScreen에서 화면 전환 시 필요
  void scrollToTop() {}

  /// MainScreen의 날짜 sync 맞추는 메소드
  void syncDate(DateTime date) {
    recordDate = date;
  }

  /// 탭 변경
  void changeTab(int index) {
    _tabManager.changeTab(index: index);
    _updateDateFilterByTab();
    _updateOrderByTab();
  }

  /// 탭에 맞춰 날짜 필터 업데이트
  void _updateDateFilterByTab() {
    dateFilter.value = _tabDateFilter[_tabController.index];
  }

  /// 날짜 필터 설정
  void _setDateFilter(HistoryDateFilterType filter) {
    var tabFilter = _tabDateFilter.toList();
    tabFilter[_tabController.index] = filter;
    _tabDateFilter.value = tabFilter;
    _updateDateFilterByTab();
  }

  /// 탭에 맞춰 순서 필터 업데이트
  void _updateOrderByTab() {
    orderFilter.value = _tabOrderFilter[_tabController.index];
  }

  /// 순서 필터 설정
  void _setOrderFilter(HistoryOrderFilterType filter) {
    var tabFilter = _tabOrderFilter.toList();
    tabFilter[_tabController.index] = filter;
    _tabOrderFilter.value = tabFilter;
    _updateOrderByTab();
  }

  void _onRefresh() {
    final tab = _tabManager.tab;

    switch (tab) {
      case HistoryTabType.wellness:
        onRefreshWellness();
      case HistoryTabType.intensity:
        onRefreshIntensity();
      case HistoryTabType.injury:
        onRefreshInjury();
      default:
        break;
    }
  }

  /// 필터 다이얼로그 보기.
  void showFilterDialog() async {
    final response = await Get.dialog(
      HistoryFilterDialog(
        args: HistoryFilterDialogArgs(
          dateType: dateFilter.value,
          orderType: orderFilter.value,
          isVisibleRecovery: _tabManager.tab.index == 2,
          isRecovery: isRecovery.value,
        ),
      ),
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 300),
    );

    if (response is HistoryFilterDialogArgs) {
      _setDateFilter(response.dateType);
      _setOrderFilter(response.orderType);
      isRecovery.value = response.isRecovery;
      _onRefresh();
    }
  }

  /// 플로팅 버튼 클릭
  void onPressedFloatingButton() {
    final tab = _tabManager.tab;

    switch (tab) {
      case HistoryTabType.wellness:
        recordWellness(recordDate: recordDate);
      case HistoryTabType.intensity:
        recordIntensity(recordDate: recordDate);
      case HistoryTabType.injury:
        recordInjury(recordDate: recordDate);
      default:
        break;
    }
  }
}
