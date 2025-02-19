import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/search_teams/items/search_teams_list_item_ui_state.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

class SearchTeamsListItem extends StatelessWidget {
  final SearchTeamsListItemUiState uiState;

  final Function(SearchTeamsListItemUiState) onTap;

  const SearchTeamsListItem({
    super.key,
    required this.uiState,
    required this.onTap,
  });

  final textStyle = const TextStyle(
    fontSize: 16,
    color: ColorRes.fontBlack,
  );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _Image(imageUrl: uiState.imageUrl),
                ),
              ),
            ),
            Expanded(
              child: Text(
                uiState.clubName,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                uiState.coachName,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: _SelectButton(
                  uiState: uiState,
                  onTap: onTap,
                ),
              ),
            )
          ],
        ),
      );
}

class _Image extends StatelessWidget {
  final String? imageUrl;

  const _Image({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    if (url == null || url.isEmpty) {
      return defaultImage();
    } else {
      return Image.network(
        url,
        width: 40,
        height: 40,
        fit: BoxFit.contain,
        errorBuilder: (
          BuildContext context,
          Object error,
          StackTrace? stackTrace,
        ) {
          return defaultImage();
        },
      );
    }
  }

  Widget defaultImage() => Container(
        padding: const EdgeInsets.all(8),
        color: ColorRes.disable,
        child: SvgPicture.asset(Assets.userDefaultBasic),
      );
}

class _SelectButton extends StatelessWidget {
  final SearchTeamsListItemUiState uiState;

  final Function(SearchTeamsListItemUiState) onTap;

  const _SelectButton({
    required this.uiState,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWellOver(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorRes.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha:0.25),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Text(
            StringRes.select.tr,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: uiState.isSelected ? ColorRes.fontBlack : ColorRes.disable,
            ),
          ),
        ),
        onTap: () => onTap(uiState),
      );
}
