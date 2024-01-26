import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';

import 'custom_picker_selection_overlay.dart';

class TimePicker extends StatelessWidget {
  final double height;

  final FixedExtentScrollController hourController;

  final FixedExtentScrollController minuteController;

  final Function(int) onSelectedHourChanged;

  final Function(int) onSelectedMinChanged;

  const TimePicker({
    super.key,
    this.height = 90,
    required this.hourController,
    required this.minuteController,
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
                controller: hourController,
                text: (int index) {
                  return StringRes.hourParams
                      .trParams({"hour": "$index"});
                },
                length: 24,
                capStartEdge: true,
                capEndEdge: false,
                onSelectedItemChanged: onSelectedHourChanged,
              ),
            ),
            Expanded(
              child: _TimePickerItem(
                controller: minuteController,
                text: (int index) {
                  return StringRes.minParams.trParams({"min": "$index"});
                },
                length: 60,
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
  final FixedExtentScrollController controller;

  final String Function(int index) text;

  final int length;

  final bool capStartEdge;

  final bool capEndEdge;

  final Function(int) onSelectedItemChanged;

  const _TimePickerItem({
    required this.controller,
    required this.text,
    required this.length,
    required this.capStartEdge,
    required this.capEndEdge,
    required this.onSelectedItemChanged,
  });

  @override
  Widget build(BuildContext context) => CupertinoPicker(
        looping: true,
        scrollController: controller,
        itemExtent: 32.0,
        onSelectedItemChanged: onSelectedItemChanged,
        selectionOverlay: CustomPickerSelectionOverlay(
          background: ColorRes.primary.withOpacity(0.3),
          capStartEdge: capStartEdge,
          capEndEdge: capEndEdge,
        ),
        children: List.generate(
          length,
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
