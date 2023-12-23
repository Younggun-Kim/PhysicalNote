import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

import 'intensity_table.dart';

class IntensityPage extends StatelessWidget {
  final int hour;

  final int minute;

  final Function(int) onSelectedHourChanged;

  final Function(int) onSelectedMinChanged;

  final bool? isSports;

  final Function(bool) onPressedWorkout;

  final int level;

  final Function(int) onPressedLevel;

  const IntensityPage({
    super.key,
    required this.hour,
    required this.minute,
    required this.onSelectedHourChanged,
    required this.onSelectedMinChanged,
    required this.isSports,
    required this.onPressedWorkout,
    required this.level,
    required this.onPressedLevel,
  });

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
                    isSelected: isSports == true,
                    onPressed: () {
                      onPressedWorkout(true);
                    }),
                const SizedBox(width: 8),
                _WorkoutButton(
                    text: StringRes.physicalTraining.tr,
                    isSelected: isSports == false,
                    onPressed: () {
                      onPressedWorkout(false);
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
