import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';

import 'bottom_sheet_list_item.dart';

/// 바텀 시트 리스트.
var bottomSheetList = (
  BuildContext context,
  List<BottomSheetListItem> items,
  Function(int id) onPressed,
) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),
    context: context,
    builder: (context) => ListView.separated(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final item = items[index];
        return Container(
          height: 56,
          decoration: BoxDecoration(
            color: ColorRes.white,
            border: Border.all(color: ColorRes.disable),
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWellOver(
            onTap: () {
              onPressed(item.id);
            },
            child: Text(
              item.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorRes.fontBlack,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext ctx, int idx) {
        return const Divider();
      },
    ),
  );
};
