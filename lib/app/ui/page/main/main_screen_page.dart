import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/feedback/feedback.dart';
import 'package:physical_note/app/ui/page/history/history.dart';
import 'package:physical_note/app/ui/page/home2/home.dart';
import 'package:physical_note/app/ui/page/main/main_screen_controller.dart';

import 'main_tab_index.dart';

class MainScreenPage extends GetView<MainScreenController> {
  static const routeName = "/main";

  const MainScreenPage({super.key});

  @override
  Widget build(BuildContext context) => PopScope(
        child: Scaffold(
          body: Stack(
            children: [
              Obx(
                () => LazyLoadIndexedStack(
                  index: controller.uiState.value.tabIndex.index,
                  children: const [
                    HistoryPage(),
                    HomePage(),
                    FeedbackPage(),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Obx(() => Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: ColorRes.borderWhite,
                      width: 0.5,
                    ),
                  ),
                ),
                child: BottomNavigationBar(
                  backgroundColor: ColorRes.white,
                  onTap: (index) {
                    final tabIndex = MainTabIndex.values[index];
                    controller.setTabIndex(tabIndex: tabIndex);
                  },
                  currentIndex: controller.uiState.value.tabIndex.index,
                  selectedLabelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.fontBlack,
                    height: 20/14
                  ),
                  selectedItemColor: ColorRes.fontBlack,
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.disable,
                  ),
                  items: [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(Assets.navigationHistory),
                      label: StringRes.bottomTabHistory.tr,
                      activeIcon:
                          SvgPicture.asset(Assets.navigationHistorySelect),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(Assets.navigationHome),
                      label: StringRes.bottomTabHome.tr,
                      activeIcon: SvgPicture.asset(Assets.navigationHomeSelect),
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(Assets.navigationFeedback),
                      label: StringRes.bottomTabFeedback.tr,
                      activeIcon:
                          SvgPicture.asset(Assets.navigationFeedbackSelect),
                    ),
                  ],
                ),
              )),
        ),
      );
}