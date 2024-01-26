import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/my_information/position/position_list_item_ui_state.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

class PositionListItem extends StatelessWidget {
  final PositionListItemUiState uiState;

  final Function(PositionListItemUiState uiState) onPressed;

  const PositionListItem({
    super.key,
    required this.uiState,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Text(
              uiState.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorRes.fontBlack,
              ),
            ),
          ),
          _SelectButton(
            uiState: uiState,
            onPressed: onPressed,
          ),
        ],
      );
}

class _SelectButton extends StatelessWidget {
  final PositionListItemUiState uiState;

  final Function(PositionListItemUiState) onPressed;

  const _SelectButton({
    required this.uiState,
    required this.onPressed,
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
        onTap: () => onPressed(uiState),
      );
}
