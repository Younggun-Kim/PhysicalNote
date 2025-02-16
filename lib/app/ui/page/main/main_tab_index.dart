import 'package:physical_note/app/resources/resources.dart';

enum MainTabIndex { home, feedback, history, assignment }

extension MainTabIndexEx on MainTabIndex {
  String toAsset(bool isActive) {
    return isActive ? _toActiveAssets() : _toInactiveAsset();
  }

  String _toInactiveAsset() {
    switch (this) {
      case MainTabIndex.home:
        return Assets.bottomNaviHome;
      case MainTabIndex.history:
        return Assets.bottomNaviHistory;
      case MainTabIndex.feedback:
        return Assets.bottomNaviSchedule;
      case MainTabIndex.assignment:
        return Assets.bottomNaviAssignment;
    }
  }

  String _toActiveAssets() {
    switch (this) {
      case MainTabIndex.home:
        return Assets.bottomNaviHomeActive;
      case MainTabIndex.history:
        return Assets.bottomNaviHistoryActive;
      case MainTabIndex.feedback:
        return Assets.bottomNaviScheduleActive;
      case MainTabIndex.assignment:
        return Assets.bottomNaviAssignmentActive;
    }
  }
}
