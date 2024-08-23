import 'package:flutter/material.dart';

import 'type/history_tab_type.dart';

/// 이력 탭 관리자
class HistoryTabManager {
  /// 탭 컨트롤러
  final TabController tabController;

  /// 현재 탭
  HistoryTabType get tab => _getCurrentTab();

  /// Constructor
  const HistoryTabManager(this.tabController);

  /// 현재 탭 얻기
  HistoryTabType _getCurrentTab() {
    final index = tabController.index;
    return HistoryTabType.values[index];
  }

  /// 리셋
  void reset() {
    tabController.index = 0;
  }

  /// 탭 변경
  void changeTab({required int index, bool animate = true}) {
    animate ? tabController.animateTo(index) : tabController.index = index;
  }
}
