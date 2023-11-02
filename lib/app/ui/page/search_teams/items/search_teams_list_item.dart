import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Image.network(
                'https://picsum.photos/250?image=9',
                width: 40,
                height: 40,
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
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorRes.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
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
