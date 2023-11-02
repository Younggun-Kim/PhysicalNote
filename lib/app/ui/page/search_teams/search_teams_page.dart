import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/search_teams/items/search_teams_list_item.dart';
import 'package:physical_note/app/ui/page/search_teams/search_teams_controller.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

/// 팀 검색 뷰.
class SearchTeamsPage extends GetView<SearchTeamsController> {
  const SearchTeamsPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: Column(
          children: [
            _Header(),
            const SizedBox(height: 40),
            _SearchTextField(),
            const SizedBox(height: 40),
            _FieldNames(),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Obx(() => ListView.builder(
                itemBuilder: (context, index) {
                  final uiState = controller.items[index];
                  return SearchTeamsListItem(
                    uiState: uiState,
                    onTap: controller.onPressedListItem,
                  );
                },
                itemCount: controller.items.length,
              )),
        ),
      );
}
