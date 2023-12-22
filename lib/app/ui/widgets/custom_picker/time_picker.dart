import 'package:flutter/cupertino.dart';
import 'package:physical_note/app/resources/resources.dart';

import 'custom_picker_selection_overlay.dart';

class TimePicker extends StatefulWidget {
  final double height;

  final int initHour;

  final int initMin;

  const TimePicker({
    super.key,
    this.height = 150,
    required this.initHour,
    required this.initMin,
  });

  @override
  State<StatefulWidget> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) => SizedBox(
        height: widget.height,
        child: Row(
          children: [
            Expanded(
              child: CupertinoPicker(
                looping: true,
                scrollController: FixedExtentScrollController(initialItem: 1),
                itemExtent: 32.0,
                onSelectedItemChanged: (int index) {
                  // Handle selected time
                },
                selectionOverlay: CustomPickerSelectionOverlay(
                  background: ColorRes.primary.withOpacity(0.2),
                  capEndEdge: false,
                ),
                children: List.generate(
                  24,
                  (index) => Text(
                    "${index + 1}시간",
                    style: const TextStyle(fontSize: 20.0, height: 1.5),
                  ),
                ),
              ),
            ),
            Expanded(
                child: CupertinoPicker(
              looping: true,
              scrollController: FixedExtentScrollController(initialItem: 1),
              itemExtent: 32.0,
              onSelectedItemChanged: (int index) {
                // Handle selected time
              },
              selectionOverlay: CustomPickerSelectionOverlay(
                background: ColorRes.primary.withOpacity(0.2),
                capStartEdge: false,
              ),
              children: List.generate(
                60,
                (index) => Text(
                  "$index분",
                  style: const TextStyle(fontSize: 20.0, height: 1.5),
                ),
              ),
            ))
          ],
        ),
      );
}
