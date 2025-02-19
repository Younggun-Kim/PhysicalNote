import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/history/history.dart';
import 'package:physical_note/app/ui/page/history/wellness/item/history_wellness_item.dart';

import 'average/average.dart';
import 'item/history_wellness_item_ui_state.dart';

class HistoryWellnessPage extends GetView<HistoryController> {
  const HistoryWellnessPage({super.key});

  @override
  Widget build(BuildContext context) => _List();
}

class _List extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) => Stack(
        children: [
          RefreshIndicator(
            color: ColorRes.primary,
            backgroundColor: ColorRes.white,
            onRefresh: controller.onRefreshWellness,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const AverageItem(),
                  PagedListView<int, HistoryWellnessItemUiState>.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    clipBehavior: Clip.none,
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
                    pagingController: controller.wellnessPagingController,
                    builderDelegate:
                        PagedChildBuilderDelegate<HistoryWellnessItemUiState>(
                      itemBuilder: (context, item, index) =>
                          HistoryWellnessItem(
                        uiState: item,
                        onPressed: () {
                          controller.onPressedWellnessItem(item);
                        },
                      ),
                      noItemsFoundIndicatorBuilder: (context) =>
                          const SizedBox(),
                    ),
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 16);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      );
}
