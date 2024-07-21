import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/ui/page/history/history.dart';
import 'package:physical_note/app/ui/page/history/wellness/item/history_wellness_item.dart';

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
            color: Colors.black,
            onRefresh: controller.onRefreshWellness,
            child: PagedListView<int, HistoryWellnessItemUiState>.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              pagingController: controller.wellnessPagingController,
              builderDelegate:
                  PagedChildBuilderDelegate<HistoryWellnessItemUiState>(
                itemBuilder: (context, item, index) => HistoryWellnessItem(
                  uiState: item,
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
