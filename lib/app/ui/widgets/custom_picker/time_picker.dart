import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';

import 'custom_picker_selection_overlay.dart';

class TimePicker extends StatelessWidget {
  final double height;

  final int initHour;

  final int initMin;

  final Function(int) onSelectedHourChanged;

  final Function(int) onSelectedMinChanged;

  const TimePicker({
    super.key,
    this.height = 90,
    this.initHour = 0,
    this.initMin = 0,
    required this.onSelectedHourChanged,
    required this.onSelectedMinChanged,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        child: Row(
          children: [
            Expanded(
              child: _TimePickerItem(
                index: initHour,
                text: (int index) {
                  return StringRes.hourParams
                      .trParams({"hour": "${index + 1}"});
                },
                capStartEdge: true,
                capEndEdge: false,
                onSelectedItemChanged: onSelectedHourChanged,
              ),
            ),
            Expanded(
              child: _TimePickerItem(
                index: initMin,
                text: (int index) {
                  return StringRes.minParams.trParams({"min": "${index + 1}"});
                },
                capStartEdge: false,
                capEndEdge: true,
                onSelectedItemChanged: onSelectedMinChanged,
              ),
            ),
          ],
        ),
      );
}

class _TimePickerItem extends StatelessWidget {
  final int index;

  final String Function(int index) text;

  final bool capStartEdge;

  final bool capEndEdge;

  final Function(int) onSelectedItemChanged;

  const _TimePickerItem({
    required this.index,
    required this.text,
    required this.capStartEdge,
    required this.capEndEdge,
    required this.onSelectedItemChanged,
  });

  @override
  Widget build(BuildContext context) => CupertinoPicker(
        looping: true,
        scrollController: FixedExtentScrollController(initialItem: index),
        itemExtent: 32.0,
        onSelectedItemChanged: onSelectedItemChanged,
        selectionOverlay: CustomPickerSelectionOverlay(
          background: ColorRes.primary.withOpacity(0.4),
          capStartEdge: capStartEdge,
          capEndEdge: capEndEdge,
        ),
        children: List.generate(
          24,
          (index) => Text(
            text(index),
            style: TextStyle(
              fontSize: 24.0,
              color: index == index ? ColorRes.fontBlack : ColorRes.disable,
            ),
          ),
        ),
      );
}
