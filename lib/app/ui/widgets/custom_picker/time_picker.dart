import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/data/intensity/intensity_page_ui_state.dart';
import 'package:physical_note/app/utils/getx/toast_message.dart';
import 'package:rxdart/rxdart.dart';

import 'custom_picker_selection_overlay.dart';

class TimePicker extends StatelessWidget {
  final IntensityPageUiState? uiState;

  final double height;

  final FixedExtentScrollController hourController;

  final FixedExtentScrollController minuteController;

  final bool isEnabled;

  final Function(int) onSelectedHourChanged;

  final Function(int) onSelectedMinChanged;

  const TimePicker({
    super.key,
    this.uiState,
    this.height = 90,
    required this.hourController,
    required this.minuteController,
    required this.isEnabled,
    required this.onSelectedHourChanged,
    required this.onSelectedMinChanged,
  });

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          SizedBox(
            height: height,
            child: Row(
              children: [
                Expanded(
                  child: _TimePickerItem(
                    controller: hourController,
                    text: (int index) {
                      return StringRes.hourParams.trParams({"hour": "$index"});
                    },
                    length: 24,
                    isEnabled: isEnabled,
                    selectedIndex: uiState?.hour,
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
                    isEnabled: isEnabled,
                    selectedIndex: uiState?.minute,
                    capStartEdge: false,
                    capEndEdge: true,
                    onSelectedItemChanged: onSelectedMinChanged,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: !isEnabled,
            child: Container(
              width: double.infinity,
              height: height,
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  showToast('운동을 선택해주세요.');
                },
                onPanUpdate: (_) {
                  showToast('운동을 선택해주세요.');
                },
              ),
            ),
          ),
        ],
      );
}

class _TimePickerItem extends StatelessWidget {
  final FixedExtentScrollController controller;

  final String Function(int index) text;

  final int length;

  final bool isEnabled;

  final int? selectedIndex;

  final bool capStartEdge;

  final bool capEndEdge;

  final Function(int) onSelectedItemChanged;

  const _TimePickerItem({
    required this.controller,
    required this.text,
    required this.length,
    required this.isEnabled,
    required this.selectedIndex,
    required this.capStartEdge,
    required this.capEndEdge,
    required this.onSelectedItemChanged,
  });

  /// 오버레이 백그라운드 색상
  Color get overlayBackgroundColor => isEnabled
      ? ColorRes.primary.withOpacity(0.3)
      : ColorRes.disable.withOpacity(0.2);

  @override
  Widget build(BuildContext context) => CupertinoPicker(
        looping: true,
        scrollController: controller,
        itemExtent: 32.0,
        onSelectedItemChanged: onSelectedItemChanged,
        selectionOverlay: CustomPickerSelectionOverlay(
          background: overlayBackgroundColor,
          capStartEdge: capStartEdge,
          capEndEdge: capEndEdge,
        ),
        children: List.generate(
          length,
          (index) => Text(
            text(index),
            style: TextStyle(
              fontSize: 24.0,
              color: index == (selectedIndex ?? index)
                  ? ColorRes.fontBlack
                  : ColorRes.disable,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
}
