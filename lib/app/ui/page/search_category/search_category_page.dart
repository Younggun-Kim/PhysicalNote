import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/search_category/item/search_category_list_item.dart';
import 'package:physical_note/app/ui/page/search_category/search_category.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

import 'item/search_category_list_item_ui_state.dart';

/// 종목 검색 뷰.
class SearchCategoryPage extends GetView<SearchCategoryController> {
  const SearchCategoryPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        resize: true,
        child: Column(
          children: [
            _Header(),
            const SizedBox(height: 40),
            _SearchTextField(),
            const SizedBox(height: 40),
            _SearchList(),
            Obx(
              () => RoundButton(
                width: double.infinity,
                isEnabled: controller.isSelectedItem.value,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                text: StringRes.next.tr,
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: ColorRes.white,
                ),
                onPressed: controller.onPressedNextButton,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      );
}

/// 헤더.
class _Header extends GetView<SearchCategoryController> {
  @override
  Widget build(BuildContext context) => Header(
        title: controller.isSports
            ? StringRes.selectSports.tr
            : StringRes.selectCategory.tr,
        showBack: true,
        onPressed: controller.close,
      );
}

/// 검색 텍스트 필드.
class _SearchTextField extends GetView<SearchCategoryController> {
  @override
  Widget build(BuildContext context) => OutlineTextField(
        controller: controller.keyword.controller,
        hint: StringRes.search.tr,
        isShowSearch: true,
        textInputAction: TextInputAction.search,
        onSubmitted: (_) {
          controller.onPressedSearchButton();
        },
        onPressedSearch: controller.onPressedSearchButton,
      ).paddingSymmetric(horizontal: 30);
}

/// 검색 리스트.
class _SearchList extends GetView<SearchCategoryController> {
  @override
  Widget build(BuildContext context) => Expanded(
        child: Stack(
          children: [
            RefreshIndicator(
              color: Colors.black,
              onRefresh: controller.onRefresh,
              child: PagedListView<int, SearchCategoryListItemUiState>(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                pagingController: controller.pagingController,
                builderDelegate:
                    PagedChildBuilderDelegate<SearchCategoryListItemUiState>(
                  itemBuilder: (context, item, index) => SearchCategoryListItem(
                    uiState: item,
                    onTap: (SearchCategoryListItemUiState uiState) {
                      controller.onPressedListItem(uiState);
                    },
                  ),
                  noItemsFoundIndicatorBuilder: (context) => const SizedBox(),
                ),
              ),
            )
          ],
        ),
      );
}
