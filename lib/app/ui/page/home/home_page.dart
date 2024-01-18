// ignore_for_file: invalid_use_of_protected_member

import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/hooper_index_status.dart';
import 'package:physical_note/app/ui/page/home/item/home_injury_check_item/home_injury_check_item_ui_state.dart';
import 'package:physical_note/app/ui/page/home/item/home_training_balance_item/home_training_balance_type.dart';
import 'package:physical_note/app/ui/page/home/model/home_statistics_chart_model.dart';
import 'package:physical_note/app/ui/page/home/model/home_urine_model.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';

import '../../../resources/resources.dart';
import 'home_constant.dart';
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
          controller: controller.scrollController,
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
                risk: controller.risk.value,
                riskPercent: controller.riskPercent.value,
                urineData: controller.urineData.value,
                workoutIntensityData: controller.workoutIntensityList.value,
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
            Obx(
              () => _SecondState(
                todayTime: controller.workoutTodayTime.value,
                yesterdayCompareTime:
                    controller.workoutYesterdayCompareTime.value,
                injuryCheckList: controller.injuryCheckList.value,
                thisWeek: controller.workoutThisWeek.value,
                thisWeekLoad: controller.workoutThisWeekStatus.value,
                lastWeek: controller.workoutLastWeek.value,
                lastWeekLoad: controller.workoutLastWeekStatus.value,
                lastFourWeek: controller.workoutLastFourWeek.value,
                lastFourWeekLoad: controller.workoutLastFourWeekStatus.value,
                lastEightWeek: controller.workoutLastEightWeek.value,
                lastEightWeekLoad: controller.workoutLastEightWeekStatus.value,
              ),
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
            () => Container(
              width: 54,
              height: 54,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                controller.userImageUrl.value,
                fit: BoxFit.cover,
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
                crossAxisAlignment: CrossAxisAlignment.center,
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
      SvgPicture.asset(
        Assets.userDefault,
        fit: BoxFit.cover,
      );
}

/// 나의상태 헤더.
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
              BaseButton(
                text: buttonName,
                height: 24,
                padding: const EdgeInsets.symmetric(horizontal: 12),
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

  final int? risk;

  final int? riskPercent;

  final HomeUrineModel? urineData;

  final List<HomeWorkoutIntensityChartUiState> workoutIntensityData;

  const _MyStateContainer({
    required this.hooperIndexData,
    required this.risk,
    required this.riskPercent,
    required this.urineData,
    required this.workoutIntensityData,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: ColorRes.borderWhite),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: IntrinsicHeight(
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
                    if (urineData == null) const SizedBox(height: 10),
                    if (urineData == null)
                      _EmptyDataText()
                    else
                      _MyStateRisk(
                        risk: risk ?? 0,
                        percent: riskPercent ?? 0,
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              DottedBorder(
                borderType: BorderType.Rect,
                dashPattern: const [6, 4],
                color: ColorRes.disable,
                customPath: (size) {
                  return Path()
                    ..moveTo(0, 0)
                    ..lineTo(0, size.height);
                },
                child: Container(),
              ),
              const SizedBox(width: 16),
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
                        urineData: urineData!,
                      ),
                    const SizedBox(height: 16),
                    _MyStateTitle(
                        title: StringRes.workoutIntensity.tr, onPressed: () {}),
                    const SizedBox(height: 10),
                    if (workoutIntensityData.isEmpty)
                      _EmptyDataText()
                    else
                      _MyStateWorkoutIntensity(
                        uiStates: workoutIntensityData,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

/// 데이터 없음.
class _EmptyDataText extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
            borderRadius: BorderRadius.circular(20),
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
            status?.toString() ?? "",
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
  final HomeUrineModel urineData;

  late final isPositiveWeight = urineData.differenceFat > 0;

  late final differenceFatColor = isPositiveWeight ? Colors.red : Colors.blue;

  late final weightWord = isPositiveWeight
      ? StringRes.emptyWeightGood.tr
      : StringRes.emptyWeightWarning.tr;

  _MyStateUrinalysis({
    required this.urineData,
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
                    "weight": urineData.weight.toString(),
                  },
                ),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "(${urineData.differenceFat}%)",
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
                  color: urineData.urine.toColor(),
                ),
              ),
              Text(
                " : ${urineData.urine.toString()}",
                style: const TextStyle(
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
  final List<HomeWorkoutIntensityChartUiState> uiStates;

  const _MyStateWorkoutIntensity({
    required this.uiStates,
  });

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 141 / (95 * max(1, uiStates.length / 2)),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: uiStates.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
            childAspectRatio: 1 / 1.5, //item 의 가로 1, 세로 1 의 비율
            mainAxisSpacing: 10, //수평 Padding
            crossAxisSpacing: 10, //수직 Padding
          ),
          itemBuilder: (BuildContext context, int index) {
            return HomeWorkoutIntensityProgressBar(uiState: uiStates[index]);
          },
        ),
      );
}

/// 나의 상태 - 부상위험도.
class _MyStateRisk extends StatelessWidget {
  final int risk;

  final int percent;

  const _MyStateRisk({
    required this.risk,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringRes.unitPercent.tr,
            style: const TextStyle(
              fontSize: 10,
              color: ColorRes.disable,
            ),
          ),
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 127 / 37,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _square(
                      number: risk,
                      backgroundColor: ColorRes.risk0,
                      isWhiteImage: false,
                      isShowImage: risk < 7),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _square(
                      number: risk,
                      backgroundColor: ColorRes.risk1,
                      isWhiteImage: false,
                      isShowImage: risk > 6 && risk < 14),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _square(
                      number: risk,
                      backgroundColor: ColorRes.risk2,
                      isWhiteImage: true,
                      isShowImage: risk > 13 && risk < 21),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _square(
                      number: risk,
                      backgroundColor: ColorRes.risk3,
                      isWhiteImage: true,
                      isShowImage: risk > 20 && risk < 24),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _numberText(0),
              const Spacer(),
              _numberText(7),
              const Spacer(),
              _numberText(14),
              const Spacer(),
              _numberText(21),
              const Spacer(),
              _numberText(28),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringRes.managementRequired.tr,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.fontRed,
                ),
              ),
              const SizedBox(width: 3),
              Text(
                "$percent%",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.fontBlack,
                ),
              ),
            ],
          )
        ],
      );

  // TODO: 이미지.svg 파일 깨짐
  Widget _square({
    required int number,
    required Color backgroundColor,
    required bool isWhiteImage,
    required bool isShowImage,
  }) =>
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),
        child: Visibility(
          visible: isShowImage,
          child: Stack(
            children: [
              Positioned(
                top: 6,
                left: 6,
                child: SvgPicture.asset(
                  isWhiteImage ? Assets.walkMan : Assets.retiredMan,
                  width: 10,
                  height: 17,
                ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Text(
                  risk.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: isWhiteImage ? ColorRes.white : ColorRes.disable,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget _numberText(int number) => Text(
        number.toString(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: ColorRes.fontDisable,
        ),
      );
}

/// 통계.
class _Statistics extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Obx(
            () => _StatisticsTitle(
              isWeekly: controller.isWeekly.value,
              onPressedMonthlyOrWeekly: controller.onPressedMonthlyOrWeekly,
            ),
          ),
          const SizedBox(height: 20),
          _StatisticsChartTitle(),
          const SizedBox(height: 10),
          Obx(
            () => _StatisticsChart(
              currentDate: controller.myStateDate.value,
              isWeekly: controller.isWeekly.value,
              chartData: controller.isWeekly.value
                  ? controller.weeklyDataList.value
                  : controller.monthlyDataList.value,
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 20);
}

/// 통계 타이틀.
class _StatisticsTitle extends StatelessWidget {
  final bool isWeekly;

  final Function(bool weekly) onPressedMonthlyOrWeekly;

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

  const _StatisticsTitle({
    required this.isWeekly,
    required this.onPressedMonthlyOrWeekly,
  });

  @override
  Widget build(BuildContext context) => Row(
        children: [
          LabelButton(
            onPressed: () {
              onPressedMonthlyOrWeekly(true);
            },
            text: StringRes.weekly.tr,
            textStyle: isWeekly ? _selectedStyle : _normalStyle,
          ),
          const SizedBox(width: 16),
          LabelButton(
            onPressed: () {
              onPressedMonthlyOrWeekly(false);
            },
            text: StringRes.monthly.tr,
            textStyle: isWeekly ? _normalStyle : _selectedStyle,
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
              color: ColorRes.intensityLine1,
            ),
          ),
          const SizedBox(width: 5),
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
              color: ColorRes.homePhysicalPurple,
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
  final DateTime currentDate;

  final bool isWeekly;

  final List<HomeStatisticsChartModel> chartData;

  const _StatisticsChart({
    required this.currentDate,
    required this.isWeekly,
    required this.chartData,
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
        maxX: 5,
        minY: 0,
        maxY: 10,
      );

  /// Bar 데이터.
  List<LineChartBarData> get lineBarData =>
      chartData.map((e) => makeBarData(data: e)).toList();

  /// Bar 데이터 생성.
  LineChartBarData makeBarData({
    required HomeStatisticsChartModel data,
  }) {
    return LineChartBarData(
      isCurved: true,
      color: data.lineColor,
      barWidth: 1,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      spots: data.toSpots(),
    );
  }

  /// Axis 값 표시.
  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            reservedSize: 30,
            showTitles: true,
          ),
        ),
        rightTitles: const AxisTitles(),
        topTitles: const AxisTitles(),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 24,
            interval: 1,
            getTitlesWidget: isWeekly
                ? _weeklyBottomTitleWidgets
                : _monthlyBottomTitleWidgets,
          ),
        ),
      );

  /// 주간 X Axis 매핑
  Widget _weeklyBottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
    );

    var weekday = "";

    int xValue = value.toInt();
    if (xValue <= HomeConstant.weeklyMaxXLength) {
      final weekdays = [
        StringRes.weekDaySun.tr,
        StringRes.weekDayMon.tr,
        StringRes.weekDayTue.tr,
        StringRes.weekDayWed.tr,
        StringRes.weekDayThu.tr,
        StringRes.weekDayFri.tr,
        StringRes.weekDaySat.tr,
      ];

      weekday = weekdays[xValue];
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(weekday, style: style),
    );
  }

  /// 월간 X Axis 매핑
  Widget _monthlyBottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
    );

    var month = "";

    int xValue = value.toInt();
    if (xValue <= HomeConstant.monthMaxXLength) {
      month = DateTime(currentDate.year,
              currentDate.month - (HomeConstant.monthMaxXLength - xValue))
          .month
          .toString();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text("$month월", style: style),
    );
  }

  /// Grid 설정.
  FlGridData get gridData => FlGridData(
        show: true,
        drawHorizontalLine: true,
        horizontalInterval: 1,
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
  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border.symmetric(
          vertical: BorderSide.none,
          horizontal: BorderSide(color: ColorRes.disable, width: 1),
        ),
      );
}

/// 두번째 나의상태
class _SecondState extends StatelessWidget {
  final String todayTime;

  final String yesterdayCompareTime;

  final List<HomeInjuryCheckItemUiState>? injuryCheckList;

  final int thisWeek;
  final HomeTrainingBalanceType thisWeekLoad;
  final int lastWeek;
  final HomeTrainingBalanceType lastWeekLoad;
  final int lastFourWeek;
  final HomeTrainingBalanceType lastFourWeekLoad;
  final int lastEightWeek;
  final HomeTrainingBalanceType lastEightWeekLoad;

  const _SecondState({
    required this.todayTime,
    required this.yesterdayCompareTime,
    required this.injuryCheckList,
    required this.thisWeek,
    required this.thisWeekLoad,
    required this.lastWeek,
    required this.lastWeekLoad,
    required this.lastFourWeek,
    required this.lastFourWeekLoad,
    required this.lastEightWeek,
    required this.lastEightWeekLoad,
  });

  bool get isPositiveYesterdayTime => yesterdayCompareTime.contains("+");

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
              title: StringRes.workoutTime.tr,
              onPressed: () {},
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "${StringRes.todayTime.tr} : $todayTime",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.fontBlack,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  "($yesterdayCompareTime분)",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: isPositiveYesterdayTime ? Colors.blue : Colors.red,
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),

            /// 트레이닝 밸런스
            Row(
              children: [
                Text(
                  StringRes.trainingBalance.tr,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.fontBlack,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  StringRes.trainingBalanceFormula.tr,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.fontDisable,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: HomeTrainingBalanceItem(
                    type: thisWeekLoad,
                    period: StringRes.thisWeek.tr,
                    average: thisWeek,
                  ),
                ),
                Expanded(
                  child: HomeTrainingBalanceItem(
                    type: lastWeekLoad,
                    period: StringRes.lastWeek.tr,
                    average: lastWeek,
                  ),
                ),
                Expanded(
                  child: HomeTrainingBalanceItem(
                    type: lastFourWeekLoad,
                    period: StringRes.lastFourWeek.tr,
                    average: lastFourWeek,
                  ),
                ),
                Expanded(
                  child: HomeTrainingBalanceItem(
                    type: lastEightWeekLoad,
                    period: StringRes.lastEightWeek.tr,
                    average: lastEightWeek,
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
            if (injuryCheckList?.isNotEmpty == true)
              Column(
                children:
                    List<Widget>.generate(injuryCheckList!.length, (index) {
                  return HomeInjuryCheckItem(
                    uiState: injuryCheckList![index],
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
