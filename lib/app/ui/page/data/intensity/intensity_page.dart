import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/workout_type.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/data/intensity/intensity_page_ui_state.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

import 'intensity_table.dart';

class IntensityPage extends StatelessWidget {
  final int hour;

  final int minute;

  final List<IntensityPageUiState> uiStates;

  final WorkoutType? workoutType;

  final Function(int) onSelectedHourChanged;

  final Function(int) onSelectedMinChanged;

  final Function(WorkoutType) onPressedWorkout;

  final Function(int) onPressedLevel;

  const IntensityPage({
    super.key,
    required this.hour,
    required this.minute,
    required this.uiStates,
    required this.workoutType,
    required this.onSelectedHourChanged,
    required this.onSelectedMinChanged,
    required this.onPressedWorkout,
    required this.onPressedLevel,
  });

  /// 운동 강도.
  int get level => uiStates.firstWhere((element) => element.type == workoutType).level ?? 0;

  @override
  Widget build(BuildContext context) => FlexibleScrollView(
        padding: const EdgeInsets.fromLTRB(30, 24, 30, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringRes.workoutTime.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: ColorRes.fontBlack,
              ),
            ),
            const SizedBox(height: 10),
            TimePicker(
              initHour: hour,
              initMin: minute,
              onSelectedHourChanged: onSelectedHourChanged,
              onSelectedMinChanged: onSelectedMinChanged,
            ),
            const SizedBox(height: 30),
            Text(
              StringRes.performedWorkout.tr,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ColorRes.fontBlack,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                _WorkoutButton(
                    text: StringRes.sportsTraining.tr,
                    isSelected: workoutType == WorkoutType.sports,
                    onPressed: () {
                      onPressedWorkout(WorkoutType.sports);
                    }),
                const SizedBox(width: 8),
                _WorkoutButton(
                    text: StringRes.physicalTraining.tr,
                    isSelected: workoutType == WorkoutType.physical,
                    onPressed: () {
                      onPressedWorkout(WorkoutType.physical);
                    }),
              ],
            ),
            const SizedBox(height: 45),
            Text(
              StringRes.workoutIntensityKorEng.tr,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ColorRes.fontBlack,
              ),
            ),
            const SizedBox(height: 12),
            IntensityTable(
              level: level,
              onPressed: onPressedLevel,
            ),
            const SizedBox(height: 30),
            RoundButton(
              width: double.infinity,
              text: StringRes.doUpdate.tr,
              onPressed: () {},
            ),
          ],
        ),
      );
}

/// 운동 버튼.
class _WorkoutButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const _WorkoutButton({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Expanded(
        child: RoundButton(
          text: text,
          isSelected: isSelected,
          selectedColor: ColorRes.primary,
          selectedTextStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorRes.white,
          ),
          backgroundColor: ColorRes.white,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorRes.borderDeselect,
          ),
          onPressed: onPressed,
        ),
      );
}
