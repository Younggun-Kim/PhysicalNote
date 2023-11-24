import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/data/hooper_index.dart';
import 'package:physical_note/app/ui/page/home/home_workout_intensity_chart/home_workout_intensity_chart_ui_state.dart';
import 'package:physical_note/app/ui/page/home/home_workout_intensity_chart/home_workout_intensity_progress_bar.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';

import '../../../resources/resources.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const _UserInformation(),
              const SizedBox(height: 48),
              Obx(
                () => _MyStateContainer(
                  hooperIndexData: controller.hooperIndexData.value,
                  emptyWeight: controller.emptyWeight.value,
                  weightPercent: controller.weightPercent.value,
                  soccerUiState: controller.workoutIntensitySoccer.value,
                  physicalUiState: controller.workoutIntensityPhysical.value,
                ),
              ),
              const SizedBox(height: 20),
              _Statistics(),
            ],
          ),
        ),
      );
}

/// User 정보
class _UserInformation extends GetView<HomeController> {
  const _UserInformation();

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Obx(
            () => SizedBox(
              width: 54,
              height: 54,
              child: controller.userImageUrl.isEmpty
                  ? SvgPicture.asset(Assets.userDefault)
                  : Image.network(controller.userImageUrl.value),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  "${controller.userClub.value} / ${controller.userClubCoach.value}",
                  style:
                      const TextStyle(fontSize: 12, color: ColorRes.fontBlack),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(
                    () => Text(
                      controller.userName.value,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: ColorRes.fontBlack,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    StringRes.sir.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorRes.fontBlack,
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWellOver(
                    onTap: controller.onPressedUserEdit,
                    child: SvgPicture.asset(
                      Assets.edit03,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ).paddingSymmetric(horizontal: 20);
}

/// 나의 상태 컨테이너.
class _MyStateContainer extends StatelessWidget {
  final HooperIndexData? hooperIndexData;

  final String emptyWeight;

  final int weightPercent;

  final HomeWorkoutIntensityChartUiState soccerUiState;

  final HomeWorkoutIntensityChartUiState physicalUiState;

  const _MyStateContainer({
    required this.hooperIndexData,
    required this.emptyWeight,
    required this.weightPercent,
    required this.soccerUiState,
    required this.physicalUiState,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorRes.borderDeselect),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  _MyStateTitle(
                      title: StringRes.hooperIndex.tr, onPressed: () {}),
                  const SizedBox(height: 10),
                  if (hooperIndexData == null)
                    _EmptyDataText()
                  else
                    _MyStateHooperIndex(hooperIndexData: hooperIndexData!),
                  const SizedBox(height: 16),
                  _MyStateTitle(
                      title: StringRes.injuryRisk.tr, onPressed: () {}),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(width: 32),
            Expanded(
              child: Column(
                children: [
                  _MyStateTitle(
                      title: StringRes.urinalysis.tr, onPressed: () {}),
                  const SizedBox(height: 10),
                  _MyStateUrinalysis(
                    emptyWeight: emptyWeight,
                    weightPercent: weightPercent,
                  ),
                  const SizedBox(height: 16),
                  _MyStateTitle(
                      title: StringRes.workoutIntensity.tr, onPressed: () {}),
                  const SizedBox(height: 20),
                  _MyStateWorkoutIntensity(
                    soccerUiState: soccerUiState,
                    physicalUiState: physicalUiState,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

/// 데이터 없음
class _EmptyDataText extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Text(
          StringRes.noData.tr,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorRes.fontBlack,
          ),
        ),
      );
}

/// 나의 상태 - 타이틀.
class _MyStateTitle extends StatelessWidget {
  final String title;

  final VoidCallback onPressed;

  const _MyStateTitle({
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: ColorRes.fontBlack,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 5),
          InkWellOver(
            onTap: onPressed,
            child: SvgPicture.asset(
              Assets.edit03,
            ),
          ),
          const Spacer(),
        ],
      );
}

/// 나의 상태 - 후퍼인덱스.
class _MyStateHooperIndex extends StatelessWidget {
  final HooperIndexData hooperIndexData;

  const _MyStateHooperIndex({
    required this.hooperIndexData,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _MyStateHooperIndexItem(text: "잠", status: hooperIndexData.sleep),
          _MyStateHooperIndexItem(text: "스트레스", status: hooperIndexData.stress),
          _MyStateHooperIndexItem(text: "피로", status: hooperIndexData.fatigue),
          _MyStateHooperIndexItem(
              text: "근육통", status: hooperIndexData.musclePain),
        ],
      );
}

/// 나의 상태 - 후퍼인덱스 아이템.
class _MyStateHooperIndexItem extends StatelessWidget {
  final String text;

  final HooperIndexStatus status;

  const _MyStateHooperIndexItem({
    required this.text,
    required this.status,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: ColorRes.fontBlack,
              ),
            ),
          ),
          Text(
            status.toString(),
            style: const TextStyle(
              fontSize: 14,
              color: ColorRes.disable,
            ),
          ),
          const SizedBox(width: 4),
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: status.toColor(),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      );
}

/// 나의상태 - 소변검사.
class _MyStateUrinalysis extends StatelessWidget {
  final String emptyWeight;

  final int weightPercent;

  late final isPositiveWeight = weightPercent > 0;

  late final weightPercentSign = isPositiveWeight ? "+" : "-";

  late final weightPercentColor = isPositiveWeight ? Colors.red : Colors.blue;

  late final weightWord = isPositiveWeight
      ? StringRes.emptyWeightGood.tr
      : StringRes.emptyWeightWarning.tr;

  _MyStateUrinalysis({
    required this.emptyWeight,
    required this.weightPercent,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                StringRes.emptyWeightParams.trParams(
                  {
                    "weight": emptyWeight,
                  },
                ),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "($weightPercentSign$weightPercent%)",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: weightPercentColor,
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 14,
                  color: ColorRes.urine3,
                ),
              ),
              const Text(
                " : 양호",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            weightWord,
            softWrap: true,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 10,
              color: weightPercentColor,
            ),
          ),
        ],
      );
}

/// 나의 상태 - 운동강도.
class _MyStateWorkoutIntensity extends StatelessWidget {
  final HomeWorkoutIntensityChartUiState soccerUiState;

  final HomeWorkoutIntensityChartUiState physicalUiState;

  const _MyStateWorkoutIntensity({
    required this.soccerUiState,
    required this.physicalUiState,
  });

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: HomeWorkoutIntensityProgressBar(uiState: soccerUiState),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: HomeWorkoutIntensityProgressBar(uiState: physicalUiState),
            ),
          ],
        ),
      );
}

/// 통계.
class _Statistics extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          _StatisticsTitle(),
          const SizedBox(height: 20),
          _StatisticsChartTitle(),
          const SizedBox(height: 10),
          Obx(
            () => _StatisticsChart(
              statisticsSports: controller.statisticsSports,
              statisticsPhysical: controller.statisticsPhysical,
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 20);
}

/// 통계 타이틀.
class _StatisticsTitle extends StatelessWidget {
  final _selectedStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: ColorRes.fontBlack,
  );

  final _normalStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: ColorRes.disable,
  );

  @override
  Widget build(BuildContext context) => Row(
        children: [
          TextButton(
            onPressed: () {},
            child: Text(
              "주간",
              style: _selectedStyle,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "월간",
              style: _normalStyle,
            ),
          ),
        ],
      );
}

/// 통계 차트 타이틀.
class _StatisticsChartTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              StringRes.workoutIntensityStatistics.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: ColorRes.fontBlack,
              ),
            ),
          ),
          Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.greenAccent,
            ),
          ),
          Text(
            StringRes.sports.tr,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorRes.fontBlack,
            ),
          ),
          const SizedBox(width: 5),
          Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            StringRes.physical.tr,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorRes.fontBlack,
            ),
          ),
        ],
      );
}

/// 통계 차트.
class _StatisticsChart extends StatelessWidget {
  final List<FlSpot> statisticsSports;

  final List<FlSpot> statisticsPhysical;

  const _StatisticsChart({
    required this.statisticsSports,
    required this.statisticsPhysical,
  });

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 1.78,
        child: LineChart(lineChartData),
      );

  LineChartData get lineChartData => LineChartData(
        // lineTouchData: lineTouchData1,
        // gridData: gridData,
        // titlesData: titlesData1,
        // borderData: borderData,
        lineBarsData: lineBarData,
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
      );

  /// Bar 데이터.
  List<LineChartBarData> get lineBarData => [
        makeBarData(statisticsSports, ColorRes.risk0),
        makeBarData(statisticsPhysical, ColorRes.intensity0),
      ];

  /// Bar 데이터 생성.
  LineChartBarData makeBarData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
        isCurved: true,
        color: color,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: spots);
  }
}
