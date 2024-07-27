import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/ui/page/history/history.dart';
import 'package:physical_note/app/ui/page/history/intensity/item/history_intensity_item.dart';
import 'package:physical_note/app/ui/page/history/intensity/item/history_intensity_item_ui_state.dart';

class HistoryIntensityPage extends GetView<HistoryController> {
  const HistoryIntensityPage({super.key});

  @override
  Widget build(BuildContext context) => _List();
}

class _List extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) => Stack(
        children: [
          RefreshIndicator(
            color: Colors.black,
            onRefresh: controller.onRefreshIntensity,
            child: PagedListView<int, HistoryIntensityItemUiState>.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(30, 24, 30, 48),
              pagingController: controller.intensityPagingController,
              builderDelegate:
                  PagedChildBuilderDelegate<HistoryIntensityItemUiState>(
                itemBuilder: (context, item, index) => HistoryIntensityItem(
                  uiState: item,
                  isFirst: index == 0,
                  onPressed: () {
                    controller.onPressedIntensityItem(item);
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
