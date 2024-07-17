import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/history/history_tab_manager.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

// 인터페이스 정의
abstract class IHistoryController {
  /// 탭바 컨트롤러
  TabController get tabController;

  /// 스크롤 컨트롤러
  ScrollController get scrollController;

  changeTab(int index);
}

class HistoryController extends BaseController
    with GetSingleTickerProviderStateMixin
    implements IHistoryController {
  late final HistoryTabManager _tabManager;
  late final TabController _tabController;

  @override
  TabController get tabController => _tabController;

  @override
  final scrollController = ScrollController();

  /// LifeCycle
  @override
  void onInit() {
    _tabController = TabController(length: 3, vsync: this);
    _tabManager = HistoryTabManager(_tabController);
    super.onInit();
  }

  @override
  onClose() {
    tabController.dispose();
  }

  /// MainScreenController에서 필요한 메소드들
  void scrollToTop() {}
  void syncDate(DateTime date) {}

  /// 인터페이스 메소드 구현
  @override
  changeTab(int index) {
    _tabManager.changeTab(index: index);
  }
}
