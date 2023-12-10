// ignore_for_file: invalid_use_of_protected_member

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/data/hooper_index_status.dart';
import 'package:physical_note/app/ui/page/home/item/home_injury_check_item/home_injury_check_item_ui_state.dart';
import 'package:physical_note/app/ui/page/home/item/home_training_balance_item/home_training_balance_type.dart';
import 'package:physical_note/app/ui/page/home/model/home_urine_model.dart';
import 'package:physical_note/app/ui/widgets/buttons/label_button.dart';
import 'package:physical_note/app/ui/widgets/buttons/outline_round_button.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';

import '../../../resources/resources.dart';
import 'home_controller.dart';
import 'item/home_injury_check_item/home_injury_check_item.dart';
import 'item/home_training_balance_item/home_training_balance_item.dart';
import 'item/home_workout_intensity_chart/home_workout_intensity_chart_ui_state.dart';
import 'item/home_workout_intensity_chart/home_workout_intensity_progress_bar.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverList(
                  delegate: SliverChildListDelegate([
                const SizedBox(height: 40),
                const _UserInformation(),
                const SizedBox(height: 48),
                Obx(
                  () => _MyStateHeader(
                    date: controller.myStateDate.value,
                    buttonName: controller.myStatePageButtonName.value,
                    onPressedNextButton: controller.onPressedNextButton,
                    onPressedCalendar: controller.onPressedCalendar,
                  ),
                ),
                const SizedBox(height: 10),
              ])),
            ];
          },
          body: Obx(
            () => PageView(
              controller: controller.myStatePageController.value,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SizedBox.expand(child: _FirstBody()),
                SizedBox.expand(child: _SecondBody()),
              ],
            ),
          ),
        ),
      );
}

class _FirstBody extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () => _MyStateContainer(
                hooperIndexData: controller.hooperIndexData.value,
                urineData: controller.urineData.value,
                soccerUiState: controller.workoutIntensitySoccer.value,
                physicalUiState: controller.workoutIntensityPhysical.value,
              ),
            ),
            const SizedBox(height: 20),
            _Statistics(),
          ],
        ),
      );
}

class _SecondBody extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            _SecondState(
              todayTime: "3시간 30분",
              differenceTime: 40,
              injuryCheckList: controller.injuryCheckList.value,
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: const Text(
                "통증위치",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: ColorRes.fontBlack,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
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
              child: Image.network(
                controller.userImageUrl.value,
                errorBuilder: profileErrorBuilder,
              ),
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

  /// 프로필 에러 빌더.
  Widget profileErrorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
  ) =>
      SvgPicture.asset(Assets.userDefault);
}

/// 나의상태 헤더.x
class _MyStateHeader extends StatelessWidget {
  final DateTime date;

  final String buttonName;

  final VoidCallback onPressedNextButton;

  final VoidCallback onPressedCalendar;

  const _MyStateHeader({
    required this.date,
    required this.buttonName,
    required this.onPressedNextButton,
    required this.onPressedCalendar,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringRes.myState.tr,
            style: const TextStyle(
              fontSize: 30,
              color: ColorRes.fontBlack,
            ),
          ),
          Row(
            children: [
              Text(
                date.toFormattedString('yyyy년 M월 d일'),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 5),
              InkWellOver(
                onTap: onPressedCalendar,
                child: SvgPicture.asset(Assets.codeBrowser),
              ),
              const Spacer(),
              OutlineRoundButton(
                text: buttonName,
                hint: "",
                height: 24,
                radius: 12,
                onPressed: onPressedNextButton,
              ),
            ],
          )
        ],
      ).paddingSymmetric(horizontal: 30);
}

/// 나의 상태 컨테이너.
class _MyStateContainer extends StatelessWidget {
  final HooperIndexData? hooperIndexData;

  final HomeUrineModel? urineData;

  final HomeWorkoutIntensityChartUiState soccerUiState;

  final HomeWorkoutIntensityChartUiState physicalUiState;

  const _MyStateContainer({
    required this.hooperIndexData,
    required this.urineData,
    required this.soccerUiState,
    required this.physicalUiState,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
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
                  if (urineData == null)
                    _EmptyDataText()
                  else
                    _MyStateUrinalysis(
                      emptyWeight: urineData!.weight.toString(),
                      differenceFat: urineData!.differenceFat,
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

/// 나의 상x태 - 후퍼인덱스.
class _MyStateHooperIndex extends StatelessWidget {
  final HooperIndexData hooperIndexData;

  const _MyStateHooperIndex({
    required this.hooperIndexData,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _MyStateHooperIndexItem(
            text: StringRes.sleep.tr,
            status: hooperIndexData.sleep,
          ),
          const SizedBox(height: 6),
          _MyStateHooperIndexItem(
            text: StringRes.stress.tr,
            status: hooperIndexData.stress,
          ),
          const SizedBox(height: 6),
          _MyStateHooperIndexItem(
            text: StringRes.fatigue.tr,
            status: hooperIndexData.fatigue,
          ),
          const SizedBox(height: 6),
          _MyStateHooperIndexItem(
            text: StringRes.musclePain.tr,
            status: hooperIndexData.musclePain,
          ),
        ],
      );
}

/// 나의 상태 - 후퍼인덱스 아이템.
class _MyStateHooperIndexItem extends StatelessWidget {
  final String text;

  final HooperIndexStatus? status;

  const _MyStateHooperIndexItem({
    required this.text,
    this.status,
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
              color: status?.toColor() ?? ColorRes.disable,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      );
}

/// 나의상태 - 소변검사.
class _MyStateUrinalysis extends StatelessWidget {
  final String emptyWeight;

  final int differenceFat;

  late final isPositiveWeight = differenceFat > 0;

  late final differenceFatColor = isPositiveWeight ? Colors.red : Colors.blue;

  late final weightWord = isPositiveWeight
      ? StringRes.emptyWeightGood.tr
      : StringRes.emptyWeightWarning.tr;

  _MyStateUrinalysis({
    required this.emptyWeight,
    required this.differenceFat,
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
                "($differenceFat%)",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: differenceFatColor,
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
              color: differenceFatColor,
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
              statisticsSports: controller.statisticsSports.value,
              statisticsPhysical: controller.statisticsPhysical.value,
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
          LabelButton(
            onPressed: () {},
            text: StringRes.weekly.tr,
            textStyle: _normalStyle,
          ),
          const SizedBox(width: 16),
          LabelButton(
            onPressed: () {},
            text: StringRes.monthly.tr,
            textStyle: _selectedStyle,
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
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(0, 16, 24, 16),
        decoration: BoxDecoration(
          border: Border.all(color: ColorRes.borderDeselect),
          borderRadius: BorderRadius.circular(24),
        ),
        child: AspectRatio(
          aspectRatio: 1.78,
          child: LineChart(lineChartData),
        ),
      );

  LineChartData get lineChartData => LineChartData(
        // lineTouchData: lineTouchData1,
        gridData: gridData,
        borderData: borderData,
        titlesData: titlesData,
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

  /// Axis 값 표시.
  FlTitlesData get titlesData => const FlTitlesData(
        show: true,
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            reservedSize: 24,
            showTitles: true,
          ),
        ),
        rightTitles: AxisTitles(),
        topTitles: AxisTitles(),
        bottomTitles: AxisTitles(),
      );

  /// Grid 설정.
  FlGridData get gridData => FlGridData(
        show: true,
        drawHorizontalLine: true,
        horizontalInterval: 0.4,
        getDrawingHorizontalLine: horizontalGridLine,
        drawVerticalLine: false,
      );

  /// Horizontal Grid Line.
  FlLine horizontalGridLine(double value) {
    return const FlLine(
      color: ColorRes.disable,
      strokeWidth: 1,
      dashArray: null,
    );
  }

  /// Border Data.
  FlBorderData get borderData => FlBorderData(show: false);
}

/// 두번째 나의상태
class _SecondState extends StatelessWidget {
  final String todayTime;

  final int differenceTime;

  final List<HomeInjuryCheckItemUiState> injuryCheckList;

  const _SecondState({
    required this.todayTime,
    required this.differenceTime,
    required this.injuryCheckList,
  });

  String differenceTimeString(int time) {
    final sign = time > 0 ? "+" : "-";
    return "($sign$time분)";
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MyStateTitle(
              title: "운동시간",
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "오늘의 시간 : $todayTime",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.fontBlack,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  differenceTimeString(differenceTime),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: differenceTime > 0 ? Colors.blue : Colors.red,
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            /// 트레이닝 밸런스
            const Row(
              children: [
                Text(
                  "트레이닝 밸런스",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.fontBlack,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  "(운동강도 X 운동시간) 평균 값",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.fontDisable,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Expanded(
                  child: HomeTrainingBalanceItem(
                    type: HomeTrainingBalanceType.walk,
                    period: "이번주",
                    average: 770,
                  ),
                ),
                Expanded(
                  child: HomeTrainingBalanceItem(
                    type: HomeTrainingBalanceType.running,
                    period: "저번주",
                    average: 1230,
                  ),
                ),
                Expanded(
                  child: HomeTrainingBalanceItem(
                    type: HomeTrainingBalanceType.retired,
                    period: "지난주",
                    average: 1515,
                  ),
                ),
                Expanded(
                  child: HomeTrainingBalanceItem(
                    type: HomeTrainingBalanceType.retired,
                    period: "지난 8주",
                    average: 1515,
                  ),
                ),
              ],
            ),

            /// 부상체크.
            const SizedBox(height: 16),
            const Text(
              "부상체크",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: ColorRes.fontBlack,
              ),
            ),
            const SizedBox(height: 16),
            if (injuryCheckList.isNotEmpty)
              Column(
                children:
                    List<Widget>.generate(injuryCheckList.length, (index) {
                  return HomeInjuryCheckItem(
                    uiState: injuryCheckList[index],
                  );
                }).toList(),
              )
            else
              Center(
                child: _EmptyDataText(),
              ),
          ],
        ),
      );
}
