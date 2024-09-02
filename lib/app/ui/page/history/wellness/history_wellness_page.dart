import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/history/history.dart';
import 'package:physical_note/app/ui/page/history/wellness/item/history_wellness_item.dart';

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
            child: PagedListView<int, HistoryWellnessItemUiState>.separated(
              shrinkWrap: true,
              clipBehavior: Clip.none,
              padding: const EdgeInsets.fromLTRB(30, 24, 30, 48),
              pagingController: controller.wellnessPagingController,
              builderDelegate:
                  PagedChildBuilderDelegate<HistoryWellnessItemUiState>(
                itemBuilder: (context, item, index) => HistoryWellnessItem(
                  uiState: item,
                  isFirst: index == 0,
                  onPressed: () {
                    controller.onPressedWellnessItem(item);
                  },
                ),
                noItemsFoundIndicatorBuilder: (context) => const SizedBox(),
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 16);
              },
            ),
          )
        ],
      );
}
