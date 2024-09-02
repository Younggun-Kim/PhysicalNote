import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/history/history.dart';

import 'item/history_injury_item.dart';
import 'item/history_injury_item_ui_state.dart';

class HistoryInjuryPage extends GetView<HistoryController> {
  const HistoryInjuryPage({super.key});

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
            onRefresh: controller.onRefreshInjury,
            child: PagedListView<int, HistoryInjuryItemUiState>.separated(
              shrinkWrap: true,
              clipBehavior: Clip.none,
              padding: const EdgeInsets.fromLTRB(30, 24, 30, 48),
              pagingController: controller.injuryPagingController,
              builderDelegate:
                  PagedChildBuilderDelegate<HistoryInjuryItemUiState>(
                itemBuilder: (context, item, index) => HistoryInjuryItem(
                  uiState: item,
                  isFirst: index == 0,
                  onPressed: () {
                    controller.onPressedInjuryItem(item);
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
