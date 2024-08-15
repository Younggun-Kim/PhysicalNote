import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/data/data.dart';
import 'package:physical_note/app/ui/page/data/data_menu_type.dart';
import 'package:physical_note/app/ui/page/main/main_screen.dart';
import 'package:physical_note/app/ui/page/main/main_tab_index.dart';
import 'package:physical_note/app/utils/link/model/link_data.dart';
import 'package:physical_note/app/utils/link/model/link_screen.dart';
import 'package:physical_note/app/utils/link/model/link_type.dart';

class InLink extends GetxService {
  /// 링크 열기.
  Future<void> open(LinkData linkData) async {
    switch (linkData.linkType) {
      case LinkType.inLink:
        await _openInLink(linkData);
        return;
      case LinkType.outLink:
        await _openOutLink(linkData);
        return;
      case LinkType.inAppLink:
        await _openInAppLink(linkData);
        return;
    }
  }

  /// InLink 열기
  Future<void> _openInLink(LinkData linkData) async {
    // final targetUrl = linkData.targetUrl;
    // if (targetUrl == null) {
    //   return;
    // }
    // if (targetUrl.isEmpty) {
    //   return;
    // }
    // final outLink = Get.find<OutLink>();
    // await outLink.moveUrl(
    //   targetUrl,
    //   mode: LaunchMode.inAppWebView,
    // );
  }

  /// OutLink 열기
  Future<void> _openOutLink(LinkData linkData) async {
    // final targetUrl = linkData.targetUrl;
    // if (targetUrl == null) {
    //   return;
    // }
    // if (targetUrl.isEmpty) {
    //   return;
    // }
    // final outLink = Get.find<OutLink>();
    // await outLink.moveUrl(targetUrl);
  }

  /// InAppLink
  Future<void> _openInAppLink(LinkData linkData) async {
    final screen = linkData.screen;
    switch (screen) {
      case LinkScreen.home:
        await _openMain(linkData);
        break;
      case LinkScreen.data:
        await _openData(linkData);
        break;
      case LinkScreen.wellness:
        await _openDataWellness(linkData);
        break;
      case LinkScreen.injury:
        await _openDataInjury(linkData);
        break;
      case LinkScreen.feedback:
      case LinkScreen.calendar:
        await _openFeedback(linkData);
        break;
      default:
        await _openMain(linkData);
        break;
    }
  }

  /// 메인의 탭 열기.
  Future<void> _openMainTab(MainTabIndex index, DateTime? recordDate) async {
    if (Get.isRegistered<MainScreenController>()) {
      final mainController = Get.find<MainScreenController>();
      if(recordDate != null) {
        mainController.syncDate(recordDate);
      }
      mainController.setTabIndex(tabIndex: index);

    }
    Get.until((route) => Get.currentRoute == MainScreenPage.routeName);
  }

  /// 메인 - 홈.
  Future<void> _openMain(LinkData linkData) async {
    await _openMainTab(MainTabIndex.home, linkData.recordDate);
  }

  /// 메인 - 데이터.
  Future<void> _openData(LinkData linkData) async {
    await _openMainTab(MainTabIndex.history, linkData.recordDate);
  }

  /// 메인 - 피드백.
  Future<void> _openFeedback(LinkData linkData) async {
    await _openMainTab(MainTabIndex.feedback, linkData.recordDate);
  }

  /// 메인 - 데이터 - 메뉴 열기
  Future<void> _openDataMenu(DataMenuType menu) async {
    if (Get.isRegistered<DataController>()) {
      final dataController = Get.find<DataController>();
      dataController.changeMenu(menu);
    }
  }

  /// 메인 - 데이터 - 웰리니스 탭.
  Future<void> _openDataWellness(LinkData linkData) async {
    await _openMainTab(MainTabIndex.history, linkData.recordDate);
    await _openDataMenu(DataMenuType.wellness);
  }

  /// 메인 - 데이터 - 부상관리 탭.
  Future<void> _openDataInjury(LinkData linkData) async {
    await _openMainTab(MainTabIndex.history, linkData.recordDate);
    await _openDataMenu(DataMenuType.injury);
  }
}
