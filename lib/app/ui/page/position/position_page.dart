import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/my_information/position/position_list_item_ui_state.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

import 'item/position_list_item.dart';
import 'position_controller.dart';

class PositionPage extends GetView<PositionController> {
  const PositionPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: Column(
          children: [
            _Header(),
            const SizedBox(height: 40),
            _SearchTextField(),
            const SizedBox(height: 40),
            _PositionList(),
            const SizedBox(height: 20),
            Obx(
              () => BaseButton(
                text: StringRes.complete.tr,
                height: 56,
                defaultBackgroundColor: ColorRes.primary,
                defaultTextStyle: const TextStyle(
                  fontSize: 16,
                  color: ColorRes.white,
                  fontWeight: FontWeight.w500,
                ),
                disableTextStyle: const TextStyle(
                  fontSize: 16,
                  color: ColorRes.white,
                  fontWeight: FontWeight.w500,
                ),
                isEnabled: controller.isEnabledCompleteButton.value,
                onPressed: controller.onPressedComplete,
              ).marginSymmetric(horizontal: 30),
            ),
            const SizedBox(height: 40),
          ],
        ),
      );
}

/// 헤더.
class _Header extends GetView<PositionController> {
  @override
  Widget build(BuildContext context) => Header(
        title: StringRes.myInformation.tr,
        showBack: true,
        onPressed: controller.close,
      );
}

/// 검색 텍스트 필드.
class _SearchTextField extends GetView<PositionController> {
  @override
  Widget build(BuildContext context) => OutlineTextField(
        controller: controller.keyword.controller,
        hint: StringRes.search.tr,
        isShowSearch: true,
        onPressedSearch: controller.onPressedSearchButton,
        onSubmitted: (_) {
          controller.onPressedSearchButton();
        },
      ).paddingSymmetric(horizontal: 30);
}

/// 포지션 목록.
class _PositionList extends GetView<PositionController> {
  @override
  Widget build(BuildContext context) => Expanded(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: controller.onRefresh,
              child: PagedListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                pagingController: controller.pagingController,
                builderDelegate:
                    PagedChildBuilderDelegate<PositionListItemUiState>(
                  itemBuilder: (context, item, index) => PositionListItem(
                    uiState: item,
                    onPressed: (PositionListItemUiState uiState) {
                      controller.onPressedListItem(uiState);
                    },
                  ),
                  noItemsFoundIndicatorBuilder: (context) => const SizedBox(),
                ),
                separatorBuilder: (context, itemIndex) {
                  return const SizedBox(height: 20);
                },
              ),
            ),
          ],
        ),
      );
}
