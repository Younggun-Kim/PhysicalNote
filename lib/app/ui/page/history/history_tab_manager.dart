import 'package:flutter/material.dart';

/// 이력 탭 관리자
class HistoryTabManager {
  /// 탭 컨트롤러
  final TabController tabController;

  const HistoryTabManager(this.tabController);

  /// 리셋
  void reset() {
    tabController.index = 0;
  }

  /// 탭 변경
  void changeTab({required int index, bool animate = true}) {
    animate ? tabController.animateTo(index) : tabController.index = index;
  }
}
