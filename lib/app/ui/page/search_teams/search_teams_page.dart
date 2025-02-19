import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/search_teams/items/search_teams_list_item.dart';
import 'package:physical_note/app/ui/page/search_teams/items/search_teams_list_item_ui_state.dart';
import 'package:physical_note/app/ui/page/search_teams/search_teams_controller.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

/// 팀 검색 뷰.
class SearchTeamsPage extends GetView<SearchTeamsController> {
  const SearchTeamsPage({super.key});

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
            _FieldNames(),
            const SizedBox(height: 20),
            _CoachList(),
            const SizedBox(height: 20),
          ],
        ),
      );
}

/// 헤더.
class _Header extends GetView<SearchTeamsController> {
  @override
  Widget build(BuildContext context) => Header(
        title: StringRes.searchTeams.tr,
        showBack: true,
        onPressed: controller.close,
      );
}

/// 검색 텍스트 필드.
class _SearchTextField extends GetView<SearchTeamsController> {
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

/// 필드명.
class _FieldNames extends StatelessWidget {
  final textStyle = const TextStyle(
    fontSize: 16,
    color: ColorRes.disable,
  );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                StringRes.logo.tr,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
                child: Text(
              StringRes.clubName.tr,
              style: textStyle,
              textAlign: TextAlign.center,
            )),
            Expanded(
              child: Text(
                StringRes.dedicatedCoach.tr,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
            const Expanded(
              child: Text(""),
            ),
          ],
        ),
      );
}

/// 코치 목록.
class _CoachList extends GetView<SearchTeamsController> {
  @override
  Widget build(BuildContext context) => Expanded(
        child: Stack(
          children: [
            RefreshIndicator(
              color: ColorRes.primary,
              backgroundColor: ColorRes.white,
              onRefresh: controller.onRefresh,
              child: PagedListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                pagingController: controller.pagingController,
                builderDelegate:
                    PagedChildBuilderDelegate<SearchTeamsListItemUiState>(
                  itemBuilder: (context, item, index) => SearchTeamsListItem(
                    uiState: item,
                    onTap: (SearchTeamsListItemUiState uiState) {
                      controller.onPressedListItem(uiState);
                    },
                  ),
                  noItemsFoundIndicatorBuilder: (context) => const SizedBox(),
                ),
                separatorBuilder: (context, itemIndex) {
                  return const SizedBox(width: 20);
                },
              ),
            ),
          ],
        ),
      );
}
