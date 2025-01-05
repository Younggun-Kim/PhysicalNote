import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/my_information/position/position_list_item_ui_state.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';

class PositionListItem extends StatelessWidget {
  final PositionListItemUiState uiState;

  final Function(PositionListItemUiState) onTap;

  const PositionListItem({
    super.key,
    required this.uiState,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWellOver(
      onTap: () {
        onTap(uiState);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 40,
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        decoration: BoxDecoration(
          color: uiState.isSelected ? ColorRes.primary : ColorRes.white,
          border: Border.all(color: ColorRes.borderDeselect),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha:0.25),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
              blurStyle: BlurStyle.normal,
            ),
          ],
        ),
        child: Text(
          uiState.name,
          style: const TextStyle(
            fontSize: 12,
            color: ColorRes.fontBlack,
          ),
        ),
      ));
}
