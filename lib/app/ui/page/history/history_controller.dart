import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/history/history_tab_manager.dart';
import 'package:physical_note/app/ui/page/history/type/history_tab_type.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

import 'type/history_filter_type.dart';

// 인터페이스 정의
abstract class IHistoryController {
  /// 탭바 컨트롤러
  TabController get tabController;

  /// 스크롤 컨트롤러
  ScrollController get scrollController;

  changeTab(int index);
}

class HistoryController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late final HistoryTabManager _tabManager;

  TabController get tabController => _tabController;

  late final TabController _tabController;

  final scrollController = ScrollController();

  /// 현재 필터
  final filter = HistoryFilterType.all.obs;

  /// 필터 목록
  final filterList = <HistoryFilterType>[].obs;

  /// 필터 모달 visible
  final isVisibleFilterModal = false.obs;

  /// LifeCycle
  @override
  void onInit() {
    _tabController =
        TabController(length: HistoryTabType.values.length, vsync: this);
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
  }

  /// 필터 설정
  void setFilter(HistoryFilterType newFilter) {
    filter.value = newFilter;
  }

  /// 필터 모달 visible 설정
  void setFilterModalVisibility(bool isVisible) {
    isVisibleFilterModal.value = isVisible;
  }
}
