import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/search_category/item/search_category_list_item_ui_state.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';

class SearchCategoryListItem extends StatelessWidget {
  final SearchCategoryListItemUiState uiState;

  final Function(SearchCategoryListItemUiState) onTap;

  const SearchCategoryListItem({
    super.key,
    required this.uiState,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                uiState.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: ColorRes.fontBlack,
                ),
              ),
            ),
            const SizedBox(width: 40),
            _SelectButton(
              uiState: uiState,
              onTap: onTap,
            ),
          ],
        ),
      );
}

class _SelectButton extends StatelessWidget {
  final SearchCategoryListItemUiState uiState;

  final Function(SearchCategoryListItemUiState) onTap;

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
