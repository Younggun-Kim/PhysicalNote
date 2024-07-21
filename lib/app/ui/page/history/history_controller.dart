import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/dialog/dropdown/dropdown_dialog.dart';
import 'package:physical_note/app/ui/page/history/history_tab_manager.dart';
import 'package:physical_note/app/ui/page/history/type/history_page_key_type.dart';
import 'package:physical_note/app/ui/page/history/type/history_tab_type.dart';
import 'package:physical_note/app/ui/page/history/wellness/history_wellness_controller.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'type/history_filter_type.dart';

class HistoryController extends BaseController
    with GetSingleTickerProviderStateMixin, HistoryWellnessController {
  late final HistoryTabManager _tabManager;

  TabController get tabController => _tabController;

  late final TabController _tabController;

  final scrollController = ScrollController();

  /// 현재 필터
  late final filter = HistoryFilterType.all.obs;

  /// 각 탭의 필터
  final _tabFilter = <HistoryFilterType>[
    HistoryFilterType.all,
    HistoryFilterType.all,
    HistoryFilterType.all,
  ].obs;

  /// 필터 목록
  final filterList = <HistoryFilterType>[].obs;

  /// 필터 모달 visible
  final isVisibleFilterModal = false.obs;

  /// LifeCycle
  @override
  void onInit() {
    _tabController = TabController(
      initialIndex: 0,
      length: HistoryTabType.values.length,
      vsync: this,
    );
    _tabManager = HistoryTabManager(_tabController);
    _setFilterList(_tabManager.tab);
    super.onInit();
  }

  @override
  onClose() {
    tabController.dispose();
  }

  /// MainScreen에서 화면 전환 시 필요
  void scrollToTop() {}

  /// MainScreen의 날짜 sync 맞추는 메소드
  void syncDate(DateTime date) {}

  /// 탭 변경
  void changeTab(int index) {
    _tabManager.changeTab(index: index);
    _setFilterList(_tabManager.tab);
  }

  /// 필터 목록 변경
  void _setFilterList(HistoryTabType tab) {
    switch (tab) {
      case HistoryTabType.wellness:
      case HistoryTabType.intensity:
        filterList.value = HistoryFilterType.commonList;
      case HistoryTabType.injury:
        filterList.value = HistoryFilterType.injuryList;
    }
    _updateFilter();
  }

  /// 현재 필터에 맞게 업데이트
  void _updateFilter() {
    filter.value = _tabFilter[_tabController.index];
  }

  /// 필터 설정
  void _setFilter(HistoryFilterType newFilter) {
    var tabFilter = _tabFilter.toList();
    tabFilter[_tabController.index] = newFilter;
    _tabFilter.value = tabFilter;
    _updateFilter();
  }

  /// 필터 모달 visible 설정
  void setFilterModalVisibility() async {
    isVisibleFilterModal.value = true;

    final list = filterList.map((e) => e.toString()).toList();
    final response = await Get.dialog(
      DropdownDialog(
        key: HistoryPageKeyType.dropDownDialog.key,
        items: list,
        top: 80,
        right: 20,
      ),
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 300),
    );

    isVisibleFilterModal.value = false;

    if (response is String) {
      final index = list.indexOf(response);
      _setFilter(filterList[index]);
    }
  }
}
