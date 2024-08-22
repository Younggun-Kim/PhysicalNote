import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/ui/page/main/main_screen.dart';
import 'package:physical_note/app/ui/page/main/main_tab_index.dart';
import 'package:physical_note/app/ui/page/wellness_detail/wellness_detail.dart';
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
      case LinkScreen.wellness:
        await _openDataWellness(linkData);
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
  Future<void> _openMainTab(MainTabIndex index) async {
    if (Get.isRegistered<MainScreenController>()) {
      final mainController = Get.find<MainScreenController>();
      mainController.setTabIndex(tabIndex: index);
    }

    Get.until((route) => Get.currentRoute == MainScreenPage.routeName);
  }

  /// 메인 - 홈.
  Future<void> _openMain(LinkData linkData) async {
    await _openMainTab(MainTabIndex.home);
  }

  /// 메인 - 피드백.
  Future<void> _openFeedback(LinkData linkData) async {
    if (Get.isRegistered<MainScreenController>()) {
      final mainController = Get.find<MainScreenController>();
      final recordDate = linkData.recordDate;
      mainController.moveFeedback(recordDate);
    }
  }

  /// 웰리니스 기록으로 이동.
  Future<void> _openDataWellness(LinkData linkData) async {
    await _openMainTab(MainTabIndex.history);
    await Future.delayed(const Duration(milliseconds: 500));

    final recordDate = linkData.recordDate ?? DateTime.now();
    final args = WellnessDetailArgs(wellnessId: null, recordDate: recordDate);
    Get.toNamed(RouteType.WELLNESS_DETAIL, arguments: args);
  }
}
