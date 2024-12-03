import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/intensity_detail/intensity_detail_ui_state.dart';
import 'package:physical_note/app/utils/getx/toast_message.dart';

class TimePicker extends StatelessWidget {
  final IntensityDetailUiState? uiState;

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

  /// 오버레이 백그라운드 색상
  Color get _overlayColor => isEnabled
      ? ColorRes.primary.withOpacity(0.3)
      : ColorRes.disable.withOpacity(0.2);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          SizedBox(
            height: height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 40),
                Expanded(
                  child: _TimePickerItem(
                    controller: hourController,
                    text: (int index) {
                      return index.toString();
                    },
                    subFixText: '',
                    length: 24,
                    isEnabled: isEnabled,
                    selectedIndex: uiState?.hour,
                    onSelectedItemChanged: onSelectedHourChanged,
                  ),
                ),
                const Text(
                  ':',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: ColorRes.fontBlack,
                    fontWeight: FontWeight.w500,
                    height: -0.3,
                  ),
                ),
                Expanded(
                  child: _TimePickerItem(
                    controller: minuteController,
                    text: (int index) {
                      return index.toString().padLeft(2, '0');
                    },
                    subFixText: '',
                    length: 60,
                    isEnabled: isEnabled,
                    selectedIndex: uiState?.minute,
                    onSelectedItemChanged: onSelectedMinChanged,
                  ),
                ),
                const SizedBox(width: 40),
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
          _Overlay(
            height: height,
            color: _overlayColor,
          ),
        ],
      );
}

class _TimePickerItem extends StatelessWidget {
  final FixedExtentScrollController controller;

  final String Function(int index) text;

  final String subFixText;

  final int length;

  final bool isEnabled;

  final int? selectedIndex;

  final Function(int) onSelectedItemChanged;

  const _TimePickerItem({
    required this.controller,
    required this.text,
    required this.subFixText,
    required this.length,
    required this.isEnabled,
    required this.selectedIndex,
    required this.onSelectedItemChanged,
  });

  @override
  Widget build(BuildContext context) => CupertinoPicker(
        looping: length > 1,
        scrollController: controller,
        itemExtent: 36.0,
        onSelectedItemChanged: onSelectedItemChanged,
        selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
          background: Colors.transparent,
        ),
        children: List.generate(length, (index) {
          final isSelected = index == selectedIndex;
          final mainFontColor =
              isSelected ? ColorRes.fontBlack : ColorRes.disable;
          final subFixFontColor =
              isSelected ? ColorRes.fontBlack : Colors.transparent;
          return RichText(
            text: TextSpan(children: [
              TextSpan(
                text: text(index),
                style: TextStyle(
                  fontSize: 24.0,
                  color: mainFontColor,
                  fontWeight: FontWeight.w500,
                  height: 36 / 26,
                ),
              ),
            ]),
          );
        }),
      );
}

class _Overlay extends StatelessWidget {
  final double height;

  final Color color;

  const _Overlay({
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => IgnorePointer(
        ignoring: true,
        child: Container(
          width: double.infinity,
          height: 36,
          margin: EdgeInsets.symmetric(vertical: (height - 36) / 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      );
}
