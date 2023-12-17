import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/data/data.dart';
import 'package:physical_note/app/ui/page/feedback/feedback.dart';
import 'package:physical_note/app/ui/page/home/home.dart';
import 'package:physical_note/app/ui/page/main/main_screen_controller.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

import 'main_tab_index.dart';

class MainScreenPage extends GetView<MainScreenController> {
  static const routeName = "/main";

  const MainScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => PopScope(
        child: Container(
          color: ColorRes.white,
          child: SafeArea(
            child: Column(
              children: [
                _createContainer(),
                _createBottomNavigation(),
              ],
            ),
          ),
        ),
      );

  /// 탭 컨테이너.
  Widget _createContainer() => Expanded(
        child: Stack(
          children: [
            Obx(
              () => LazyLoadIndexedStack(
                index: controller.uiState.value.tabIndex.index,
                children: [
                  const DataPage(),
                  const HomePage(),
                  const FeedbackPage(),
                ],
              ),
            ),
          ],
        ),
      );

  /// 바텀 네비게이션.
  Widget _createBottomNavigation() => Container(
        height: 80,
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: ColorRes.borderWhite)),
        ),
        child: Row(
          children: [
            _createTab(
              Assets.navigationData,
              Assets.navigationDataSelect,
              MainTabIndex.data,
            ),
            _createTab(
              Assets.navigationHome,
              Assets.navigationHomeSelect,
              MainTabIndex.home,
            ),
            _createTab(
              Assets.navigationFeedback,
              Assets.navigationFeedbackSelect,
              MainTabIndex.feedback,
            ),
          ],
        ),
      );

  /// 탭.
  Widget _createTab(String onIcon, String offIcon, MainTabIndex tabIndex) =>
      Obx(
        () => Expanded(
          child: InkWellOver(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SvgPicture.asset(
                    controller.uiState.value.tabIndex == tabIndex
                        ? onIcon
                        : offIcon,
                  ),
                ],
              ),
            ),
            onTap: () {
              controller.setTabIndex(tabIndex);
            },
          ),
        ),
      );
}
