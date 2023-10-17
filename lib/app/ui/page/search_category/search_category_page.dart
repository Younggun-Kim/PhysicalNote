import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/search_category/item/search_category_list_item.dart';
import 'package:physical_note/app/ui/page/search_category/search_category.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

/// 종목 검색 뷰.
class SearchCategoryPage extends GetView<SearchCategoryController> {
  const SearchCategoryPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        resize: false,
        child: Column(
          children: [
            _Header(),
            const SizedBox(height: 40),
            _SearchTextField(),
            const SizedBox(height: 40),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Obx(() => ListView.builder(
                      itemBuilder: (context, index) {
                        final uiState = controller.items[index];
                        return SearchCategoryListItem(
                          uiState: uiState,
                          onTap: controller.onPressedListItem,
                        );
                      },
                      itemCount: controller.items.length,
                    )),
              ),
            ),
            const SizedBox(height: 40),
            Obx(
              () => RoundButton(
                width: double.infinity,
                isEnabled: controller.isSelectedListItem.value,
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
        title: StringRes.selectCategory.tr,
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
        onPressedSearch: controller.onPressedSearchButton,
      ).paddingSymmetric(horizontal: 30);
}
