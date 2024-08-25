import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/workout_type.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/intensity_detail/intensity_table.dart';
import 'package:physical_note/app/ui/page/intensity_detail/intensity_detail_controller.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';

class IntensityDetailPage extends GetView<IntensityDetailController> {
  const IntensityDetailPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
      controller: controller,
      child: Column(
        children: [
          _Header(),
          Expanded(
            child: _IntensityDetailPage(),
          ),
        ],
      ));
}

class _IntensityDetailPage extends GetView<IntensityDetailController> {
  @override
  Widget build(BuildContext context) => FlexibleScrollView(
        padding: const EdgeInsets.fromLTRB(30, 24, 30, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Title(
              onTapGuide: () {},
            ),
            const SizedBox(height: 10),
            _Date(),
            const SizedBox(height: 40),
            Text(
              StringRes.workoutTime.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: ColorRes.fontBlack,
              ),
            ),
            const SizedBox(height: 30),
            Obx(
              () => Row(
                children: [
                  _WorkoutButton(
                      text: StringRes.sportsTraining.tr,
                      isSelected: controller.isSport.value,
                      onPressed: () {
                        controller.onPressedType(WorkoutType.sports);
                      }),
                  const SizedBox(width: 30),
                  _WorkoutButton(
                      text: StringRes.physicalTraining.tr,
                      isSelected: controller.isPhysical.value,
                      onPressed: () {
                        controller.onPressedType(WorkoutType.physical);
                      }),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _TimePicker(),
            const SizedBox(height: 40),
            Text(
              StringRes.workoutIntensityKorEng.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorRes.fontBlack,
              ),
            ),
            const SizedBox(height: 12),
            Obx(() {
              final uiState = controller.currentUiState.value;
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

/// 헤더.
class _Header extends GetView<IntensityDetailController> {
  @override
  Widget build(BuildContext context) => Header(
        title: '',
        showBack: true,
        onPressed: controller.close,
      );
}

/// 타이틀
class _Title extends StatelessWidget {
  final Function() onTapGuide;

  const _Title({required this.onTapGuide});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              StringRes.workoutIntensity.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: ColorRes.fontBlack,
              ),
            ),
          ),
        ],
      );
}

/// 날짜
class _Date extends GetView<IntensityDetailController> {
  String get formattedDate =>
      controller.recordDate.value.toFormattedString('yy년 M월 d일 (E)');

  @override
  Widget build(BuildContext context) => Obx(() => InkWellOver(
        onTap: controller.onPressedCalendar,
        child: Row(
          children: [
            Text(
              formattedDate,
              style: const TextStyle(
                fontSize: 16,
                color: ColorRes.gray9f9f9f,
              ),
            ),
            const SizedBox(width: 5),
            SvgPicture.asset(Assets.codeBrowser),
          ],
        ),
      ));
}

/// 타임 피커
class _TimePicker extends GetView<IntensityDetailController> {
  @override
  Widget build(BuildContext context) => Obx(() => TimePicker(
        uiState: controller.currentUiState.value,
        hourController: controller.hourController,
        minuteController: controller.minuteController,
        isEnabled: controller.timePickerEnabled.value,
        onSelectedHourChanged: controller.onSelectedHourChanged,
        onSelectedMinChanged: controller.onSelectedMinChanged,
      ));
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
          height: 44,
          isSelected: isSelected,
          selectedColor: ColorRes.primary,
          selectedTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorRes.white,
          ),
          backgroundColor: ColorRes.white,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorRes.gray9f9f9f,
          ),
          onPressed: onPressed,
        ),
      );
}
