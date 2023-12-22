import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';

import 'custom_picker_selection_overlay.dart';

class TimePicker extends StatefulWidget {
  final double height;

  final int initHour;

  final int initMin;

  const TimePicker({
    super.key,
    this.height = 90,
    this.initHour = 0,
    this.initMin = 0,
  });

  @override
  State<StatefulWidget> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  int selectedHour = 0;

  int selectedMin = 0;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initHour;
    selectedMin = widget.initMin;
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: widget.height,
        child: Row(
          children: [
            Expanded(
              child: CupertinoPicker(
                looping: true,
                scrollController:
                    FixedExtentScrollController(initialItem: widget.initHour),
                itemExtent: 32.0,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    selectedHour = index;
                  });
                },
                selectionOverlay: CustomPickerSelectionOverlay(
                  background: ColorRes.primary.withOpacity(0.4),
                  capEndEdge: false,
                ),
                children: List.generate(
                  24,
                  (index) => Text(
                    StringRes.hourParams.trParams({"hour": "$index"}),
                    style: TextStyle(
                      fontSize: 24.0,
                      color: index == selectedHour
                          ? ColorRes.fontBlack
                          : ColorRes.disable,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                looping: true,
                scrollController:
                    FixedExtentScrollController(initialItem: widget.initMin),
                itemExtent: 32.0,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    selectedMin = index;
                  });
                },
                selectionOverlay: CustomPickerSelectionOverlay(
                  background: ColorRes.primary.withOpacity(0.4),
                  capStartEdge: false,
                ),
                children: List.generate(
                  60,
                  (index) => Text(
                    StringRes.minParams.trParams({"min": "$index"}),
                    style: TextStyle(
                      fontSize: 24.0,
                      color: index == selectedMin
                          ? ColorRes.fontBlack
                          : ColorRes.disable,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
