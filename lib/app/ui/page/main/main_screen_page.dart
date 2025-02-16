import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:physical_note/app/ui/page/assignment/assignment.dart';
import 'package:physical_note/app/ui/page/feedback/feedback.dart';
import 'package:physical_note/app/ui/page/history/history.dart';
import 'package:physical_note/app/ui/page/home/home.dart';
import 'package:physical_note/app/ui/page/main/main_screen.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

class MainScreenPage extends GetView<MainScreenController> {
  static const routeName = "/main";

  const MainScreenPage({super.key});

  @override
  Widget build(BuildContext context) => PopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Obx(
                () => LazyLoadIndexedStack(
                  index: controller.uiState.value.tabIndex.index,
                  children: const [
                    HomePage(),
                    FeedbackPage(),
                    HistoryPage(),
                    AssignmentPage(),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: CustomFloatingBtn(
            onPressed: () {},
          ),
          bottomNavigationBar: Obx(
            () => CustomNaviBar(
              current: controller.uiState.value.tabIndex,
              onPressed: (MainTabIndex tab) => controller.changeTab(
                tabIndex: tab,
              ),
            ),
          ),
        ),
      );
}
