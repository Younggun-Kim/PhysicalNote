import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/workout_type.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/data/data.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

import '../../intensity_detail/intensity_table.dart';

class IntensityPage extends GetView<DataController> {
  const IntensityPage({
    super.key,
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
            Text(
              StringRes.performedWorkout.tr,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ColorRes.fontBlack,
              ),
            ),
            const SizedBox(height: 30),
            Obx(
              () => Row(
                children: [
                  _WorkoutButton(
                      text: StringRes.sportsTraining.tr,
                      isSelected: controller.intensityWorkoutType.value ==
                          WorkoutType.sports,
                      onPressed: () {
                        controller.onPressedWorkout(WorkoutType.sports);
                      }),
                  const SizedBox(width: 8),
                  _WorkoutButton(
                      text: StringRes.physicalTraining.tr,
                      isSelected: controller.intensityWorkoutType.value ==
                          WorkoutType.physical,
                      onPressed: () {
                        controller.onPressedWorkout(WorkoutType.physical);
                      }),
                ],
              ),
            ),
            const SizedBox(height: 45),
            // Obx(
            //   () => TimePicker(
            //     uiState: controller.intensityCurrentUiState.value,
            //     hourController: controller.intensityHourController,
            //     minuteController: controller.intensityMinuteController,
            //     isEnabled: controller.intensityTimePickerEnabled.value,
            //     onSelectedHourChanged: controller.onSelectedHourChanged,
            //     onSelectedMinChanged: controller.onSelectedMinChanged,
            //   ),
            // ),
            const SizedBox(height: 30),
            Text(
              StringRes.workoutIntensityKorEng.tr,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: ColorRes.fontBlack,
              ),
            ),
            const SizedBox(height: 12),
            Obx(() {
              final uiState = controller.intensityCurrentUiState.value;
              return Column(
                children: [
                  IntensityTable(
                    level: uiState?.level ?? 0,
                    onPressed: controller.onPressedLevel,
                  ),
                  const SizedBox(height: 30),
                  RoundButton(
                    width: double.infinity,
                    isEnabled: uiState?.isEnabled ?? false,
                    text: StringRes.save.tr,
                    onPressed: controller.onPressedSaveButton,
                  ),
                ],
              );
            }),
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
