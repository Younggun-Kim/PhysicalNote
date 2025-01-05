import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/history/intensity/item/history_intensity_item_ui_state.dart';
import 'package:physical_note/app/ui/widgets/level_progress_bar/level_progress_bar.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

class HistoryIntensityItem extends StatelessWidget {
  final bool isFirst;
  final HistoryIntensityItemUiState uiState;
  final VoidCallback onPressed;

  const HistoryIntensityItem({
    super.key,
    this.isFirst = false,
    required this.uiState,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => isFirst
      ? Column(
          children: [
            _Average(
              lastWeekWorkoutTime: uiState.lastWeekAverageTime,
              weekWorkoutTime: uiState.thisWeekAverageTime,
              sports: uiState.sportLevelAverage,
              physical: uiState.physicalLevelAverage,
            ),
            if (!uiState.onlyAverage)
              _Content(uiState: uiState, onPressed: onPressed),
          ],
        )
      : _Content(uiState: uiState, onPressed: onPressed);
}

class _Average extends StatelessWidget {
  final String? lastWeekWorkoutTime;

  final String? weekWorkoutTime;

  final double? sports;

  final double? physical;

  const _Average({
    required this.lastWeekWorkoutTime,
    required this.weekWorkoutTime,
    required this.sports,
    required this.physical,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringRes.workoutTimeAverage.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorRes.fontBlack,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _WorkoutTimeAverageItem(
                    title: StringRes.lastWeek.tr,
                    time: lastWeekWorkoutTime ?? '-',
                    fontColor: ColorRes.grayEdeded,
                  ),
                  const SizedBox(height: 10),
                  _WorkoutTimeAverageItem(
                    title: StringRes.thisWeek.tr,
                    time: weekWorkoutTime ?? '-',
                    fontColor: ColorRes.fontBlack,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20), // 1st Width
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringRes.workoutIntensityAverage.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorRes.fontBlack,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LevelProgressBar(
                        size: _getProgressBarSize(context),
                        title: StringRes.sports.tr,
                        value: sports ?? 0,
                        primaryColor: ColorRes.secondPrimary,
                      ),
                      const SizedBox(width: 14), // 2nd Width
                      LevelProgressBar(
                        size: _getProgressBarSize(context),
                        title: StringRes.physical.tr,
                        value: physical ?? 0,
                        primaryColor: ColorRes.secondPrimary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  double _getProgressBarSize(BuildContext context) {
    // 주석으로 width 표시, 위에 참고
    const double horizontalPadding = 40;
    const double firstWidth = 60;
    const double secondWidth = 14;
    return (MediaQuery.of(context).size.width -
            horizontalPadding -
            firstWidth -
            secondWidth) /
        4;
  }
}

class _WorkoutTimeAverageItem extends StatelessWidget {
  final String title;

  final String time;

  final Color? fontColor;

  const _WorkoutTimeAverageItem({
    required this.title,
    required this.time,
    required this.fontColor,
  });

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: fontColor,
              letterSpacing: -0.5,
              height: 14 / 10,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            time,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: fontColor,
              height: 32 / 22,
              letterSpacing: -0.5,
            ),
          ),
        ],
      );
}

class _Content extends StatelessWidget {
  final HistoryIntensityItemUiState uiState;

  final VoidCallback onPressed;

  const _Content({
    required this.uiState,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => InkWellOver(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha:0.25),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 4), // changes position of shadow
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                uiState.displayRecordDate,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.gray9f9f9f,
                  letterSpacing: -0.7,
                ),
              ),
              const SizedBox(height: 6),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(width: uiState.sportLevel == 10 ? 0 : 8),
                          _Level(level: uiState.sportLevel),
                          SizedBox(width: uiState.sportLevel == 10 ? 12 : 24),
                          _IntensityTime(
                            title: StringRes.sports.tr,
                            time: uiState.displaySportTime,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      color: ColorRes.divider,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                              width: uiState.physicalLevel == 10 ? 16 : 24),
                          _Level(level: uiState.physicalLevel),
                          SizedBox(
                              width: uiState.physicalLevel == 10 ? 12 : 24),
                          Expanded(
                            child: _IntensityTime(
                              title: StringRes.physical.tr,
                              time: uiState.displayPhysicalTime,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

class _Level extends StatelessWidget {
  final int? level;

  const _Level({required this.level});

  @override
  Widget build(BuildContext context) => Text(
        level?.toString() ?? '-',
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: ColorRes.intensity0,
          height: 48 / 30,
        ),
      );
}

class _IntensityTime extends StatelessWidget {
  final String title;
  final String? time;

  const _IntensityTime({
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorRes.fontBlack,
              letterSpacing: -0.5,
              height: 20 / 12,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            time ?? '-',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorRes.fontBlack,
              height: 20 / 16,
              letterSpacing: -0.5,
            ),
          ),
        ],
      );
}
