import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/hooper_index_type.dart';
import 'package:physical_note/app/config/constant/index.dart';
import 'package:physical_note/app/config/constant/urine_status_type.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/home2/home.dart';
import 'package:physical_note/app/ui/page/home2/items/today_training/home_today_training_item.dart';
import 'package:physical_note/app/ui/widgets/flexible_scroll_view.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';
import 'package:physical_note/app/ui/widgets/level_progress_bar/level_progress_bar.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: FlexibleScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _UserInfo(),
              const SizedBox(height: 20),
              _RecordButtons(),
              const SizedBox(height: 20),
              _FieldName(text: StringRes.todayTraining.tr),
              const SizedBox(height: 12),
              AspectRatio(
                aspectRatio: 375 / 104,
                child: _TodayTraining(),
              ),
              const SizedBox(height: 10),
              _TodayTrainingIndicator(),
              const SizedBox(height: 20),
              _FieldName(text: StringRes.injuryRisk.tr),
              Text(
                StringRes.beCarefulWorkingOutToday.tr,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.grayBababa,
                  letterSpacing: -0.5,
                  height: 20 / 14,
                ),
              ).marginSymmetric(horizontal: 24),
              const SizedBox(height: 20),
              _InjuryRisk(),
              const SizedBox(height: 20),
              _Wellness(),
              const SizedBox(height: 12),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _Intensity()),
                    const SizedBox(width: 12),
                    Expanded(child: _Injury()),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}

/// 필드명
class _FieldName extends StatelessWidget {
  final String text;

  const _FieldName({required this.text});

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: ColorRes.fontBlack,
          letterSpacing: -0.5,
          height: 24 / 16,
        ),
      ).marginSymmetric(horizontal: 24);
}

/// 로그인한 유저의 정보
class _UserInfo extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.userDefaultGreen,
            width: 54,
            height: 54,
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: '홍길동 ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: ColorRes.fontBlack,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const WidgetSpan(child: SizedBox(width: 2)),
                    TextSpan(
                      text: StringRes.sir.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: ColorRes.fontBlack,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const WidgetSpan(child: SizedBox(width: 8)),
                    WidgetSpan(
                      child: InkWellOver(
                        onTap: () {},
                        child: SvgPicture.asset(
                          Assets.editGreen,
                          width: 19,
                          height: 19,
                        ),
                      ),
                    ),
                  ]),
                ),
                const Text(
                  '여기저기FC / 정하진',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.fontBlack,
                    letterSpacing: -0.5,
                    height: 20 / 14,
                  ),
                )
              ],
            ),
          ),
        ],
      ).marginSymmetric(horizontal: 24);
}

/// 기록 버튼 목록
class _RecordButtons extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: _RecordButton(
              text: StringRes.wellness.tr,
              asset: Assets.wellnessIcon,
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _RecordButton(
              text: StringRes.workoutIntensity.tr,
              asset: Assets.intensityIcon,
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _RecordButton(
              text: StringRes.injuryCheck.tr,
              asset: Assets.injuryIcon,
              onPressed: () {},
            ),
          ),
        ],
      ).marginSymmetric(horizontal: 24);
}

/// 기록 버튼
class _RecordButton extends StatelessWidget {
  final String asset;

  final String text;

  final VoidCallback onPressed;

  const _RecordButton({
    required this.asset,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => InkWellOver(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24),
        child: AspectRatio(
          aspectRatio: 100 / 82,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorRes.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(child: SvgPicture.asset(asset)),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.fontBlack,
                    letterSpacing: -0.5,
                    height: 24 / 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

/// 오늘의 훈련
class _TodayTraining extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => Obx(
        () {
          if (controller.todayTrainingItems.isEmpty) {
            return Center(
              child: _TodayTrainingEmpty(),
            );
          } else {
            return PageView.builder(
              controller: controller.todayTrainingController,
              scrollDirection: Axis.horizontal,
              itemCount: controller.todayTrainingItems.length,
              itemBuilder: (BuildContext context, int index) {
                final items = controller.todayTrainingItems.toList();
                final uiState = items[index];
                return HomeTodayTrainingItem(uiState: uiState);
              },
            );
          }
        },
      );
}

/// 오늘의 훈련 Empty Case
class _TodayTrainingEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: ColorRes.thirdPrimary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          StringRes.noRegisteredTrainingToday.tr,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ColorRes.fontBlack,
            letterSpacing: -0.5,
            height: 20 / 14,
          ),
        ),
      );
}

/// 오늘의 훈련 - Indicator
class _TodayTrainingIndicator extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => Obx(
        () => Center(
          child: SmoothPageIndicator(
            controller: controller.todayTrainingController,
            count: controller.todayTrainingItems.length,
            effect: const WormEffect(
              dotHeight: 6,
              dotWidth: 6,
              type: WormType.thinUnderground,
              dotColor: ColorRes.grayD9d9d9,
              activeDotColor: ColorRes.intensity0,
            ),
          ),
        ),
      );
}

/// 부상위험도
class _InjuryRisk extends GetView<HomeController> {
  /// x label text style
  final labelTextStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: ColorRes.grayBababa,
    height: 20 / 14,
  );

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(Assets.runningManDeepGreen),
              const Text(
                '65%',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.intensity0,
                ),
              )
            ],
          ),
          const _ProgressBar(
            height: 10,
            value: 7,
            maxValue: 28,
            color: ColorRes.intensity0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0', style: labelTextStyle),
              Text('7', style: labelTextStyle),
              Text('14', style: labelTextStyle),
              Text('21', style: labelTextStyle),
              Text('28', style: labelTextStyle),
            ],
          )
        ],
      ).marginSymmetric(horizontal: 24);
}

/// 프로그레스 바
class _ProgressBar extends StatelessWidget {
  final double height;

  final int value;

  final int maxValue;

  final Color? color;

  const _ProgressBar({
    required this.height,
    required this.value,
    required this.maxValue,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Container(
        height: height,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorRes.fourthPrimary),
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            Expanded(
              flex: value,
              child: Container(
                width: (context.width - 48) * (value / maxValue),
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            Expanded(flex: maxValue - value, child: const SizedBox()),
          ],
        ),
      );
}

/// 웰리니스
class _Wellness extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  StringRes.wellness.tr,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: ColorRes.fontBlack,
                    letterSpacing: -0.5,
                    height: 20 / 12,
                  ),
                ),
                InkWellOver(
                  onTap: () {},
                  child: Text(
                    StringRes.moreShow.tr,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorRes.grayBababa,
                      letterSpacing: -0.5,
                      height: 18 / 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => _HooperIndexAverage(
                    value: controller.hooperIndexAverage.value ?? 0,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Obx(
                    () => _HooperIndexItems(
                      sleep: controller.hooperIndexSleep.value ?? 0,
                      stress: controller.hooperIndexStress.value ?? 0,
                      fatigue: controller.hooperIndexFatigue.value ?? 0,
                      muscleSoreness:
                          controller.hooperIndexMuscleSoreness.value ?? 0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Obx(
                    () => _WellnessUrine(
                      urine: controller.urine.value,
                      description: controller.urineDescription.value,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: _WellnessEmptyWeight(
                    weight: 72.1,
                    difference: -2,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: _WellnessBmi(
                    bmi: 14,
                  ),
                ),
              ],
            )
          ],
        ),
      );
}

/// 후퍼인덱스 평균
class _HooperIndexAverage extends StatelessWidget {
  final int value;

  const _HooperIndexAverage({
    required this.value,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: 95,
        height: 110,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorRes.intensity0,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              bottom: 0,
              right: -8,
              child: Image.asset(
                Assets.homeWellnessHuman,
                width: 84,
                height: 84,
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              child: Text(
                StringRes.hooperIndexAverage.tr,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.grayBababa,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            Positioned(
              bottom: 7,
              left: 9,
              child: Text(
                '$value',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.intensity0,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ],
        ),
      );
}

/// 후퍼인덱스 아이템
class _HooperIndexItem extends StatelessWidget {
  final HooperIndexType type;

  final int value;

  final Color color;

  const _HooperIndexItem({
    required this.type,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.fontBlack,
                  letterSpacing: -0.5,
                  height: 18 / 12,
                ),
              ),
              Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.grayBababa,
                  letterSpacing: -0.5,
                  height: 18 / 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          _ProgressBar(
            height: 8,
            value: value,
            maxValue: 7,
            color: color,
          ),
        ],
      );
}

/// 후퍼인덱스 아이템s
class _HooperIndexItems extends StatelessWidget {
  final int sleep;
  final int stress;
  final int fatigue;
  final int muscleSoreness;

  const _HooperIndexItems({
    required this.sleep,
    required this.stress,
    required this.fatigue,
    required this.muscleSoreness,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _HooperIndexItem(
            type: HooperIndexType.sleep,
            value: sleep,
            color: ColorRes.wellness5,
          ),
          const SizedBox(height: 12),
          _HooperIndexItem(
            type: HooperIndexType.stress,
            value: stress,
            color: ColorRes.wellness3,
          ),
          const SizedBox(height: 12),
          _HooperIndexItem(
            type: HooperIndexType.fatigue,
            value: fatigue,
            color: ColorRes.wellness6,
          ),
          const SizedBox(height: 12),
          _HooperIndexItem(
            type: HooperIndexType.muscleSoreness,
            value: muscleSoreness,
            color: ColorRes.wellness2,
          ),
        ],
      );
}

/// 소변 상태
class _WellnessUrine extends StatelessWidget {
  final UrineStatusType urine;

  final String description;

  const _WellnessUrine({
    required this.urine,
    required this.description,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringRes.urineState.tr,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: ColorRes.fontBlack,
              letterSpacing: -0.5,
              height: 14 / 10,
            ),
          ),
          const SizedBox(height: 5),
          if (urine == UrineStatusType.none)
            SvgPicture.asset(
              Assets.urineEmptyBox,
              width: 43,
              height: 13,
            ),
          if (urine != UrineStatusType.none)
            Container(
              width: 42,
              height: 13,
              decoration: BoxDecoration(
                color: urine.toColor(),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 0),
                    blurRadius: 1,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          const SizedBox(height: 5),
          Text(
            description,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorRes.grayBababa,
              letterSpacing: -0.5,
              height: 16 / 12,
            ),
          ),
        ],
      );
}

/// 공복몸무게
class _WellnessEmptyWeight extends StatelessWidget {
  final double weight;

  final double difference;

  const _WellnessEmptyWeight({
    required this.weight,
    required this.difference,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringRes.emptyWeight.tr,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: ColorRes.fontBlack,
              letterSpacing: -0.5,
              height: 14 / 10,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${weight}kg',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: ColorRes.intensity0,
              letterSpacing: -0.5,
              height: 28 / 20,
            ),
          ),
          Text(
            '($difference%)',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorRes.fontBlack,
              letterSpacing: -0.5,
              height: 16 / 12,
            ),
          ),
        ],
      );
}

/// 체지방
class _WellnessBmi extends StatelessWidget {
  final double bmi;

  const _WellnessBmi({
    required this.bmi,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringRes.emptyWeight.tr,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: ColorRes.fontBlack,
              letterSpacing: -0.5,
              height: 14 / 10,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$bmi%',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: ColorRes.intensity0,
              letterSpacing: -0.5,
              height: 28 / 20,
            ),
          ),
        ],
      );
}

/// 운동강도
class _Intensity extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(left: 24),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  StringRes.intensity.tr,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: ColorRes.fontBlack,
                    letterSpacing: -0.5,
                    height: 20 / 12,
                  ),
                ),
                InkWellOver(
                  onTap: () {},
                  child: Text(
                    StringRes.moreShow.tr,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorRes.grayBababa,
                      letterSpacing: -0.5,
                      height: 18 / 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            const Text(
              '시간 : 3시간30분',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: ColorRes.fontBlack,
                letterSpacing: -0.5,
                height: 14 / 10,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LevelProgressBar(
                  size: 56,
                  title: StringRes.sports.tr,
                  value: 4,
                  primaryColor: ColorRes.intensity0,
                ),
                LevelProgressBar(
                  size: 56,
                  title: StringRes.physical.tr,
                  value: 6,
                  primaryColor: ColorRes.intensity0,
                ),
              ],
            )
          ],
        ),
      );
}

/// 부상현황
class _Injury extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(right: 24),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  StringRes.injuryCurrentSituation.tr,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: ColorRes.fontBlack,
                    letterSpacing: -0.5,
                    height: 20 / 12,
                  ),
                ),
                InkWellOver(
                  onTap: () {},
                  child: Text(
                    StringRes.moreShow.tr,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorRes.grayBababa,
                      letterSpacing: -0.5,
                      height: 18 / 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            const _InjuryItem(
              level: InjuryLevelType.veryHighPain,
              muscleType: MuscleType.iliotibialBAND,
              injuryType: InjuryType.contact,
            ),
            const _InjuryItem(
              level: InjuryLevelType.noPain,
              muscleType: MuscleType.iliotibialBAND,
              injuryType: InjuryType.contact,
            ),
          ],
        ),
      );
}

/// 부상현황 아이템
class _InjuryItem extends StatelessWidget {
  final InjuryLevelType level;

  final MuscleType muscleType;

  final InjuryType injuryType;

  const _InjuryItem({
    required this.level,
    required this.muscleType,
    required this.injuryType,
  });

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
            decoration: BoxDecoration(
                border: Border.all(color: level.toBorderColor()),
                borderRadius: BorderRadius.circular(20),
                color: level.toBackgroundColor()),
            child: Text(
              '${level.level}단계',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w300,
                color: level.toFontColor(),
                letterSpacing: -0.5,
                height: 14 / 10,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  muscleType.toKor(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: ColorRes.fontBlack,
                    letterSpacing: -0.5,
                    height: 14 / 10,
                  ),
                ),
                Text(
                  injuryType.toString(),
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    color: ColorRes.fontBlack,
                    letterSpacing: -0.5,
                    height: 20 / 8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ).marginOnly(bottom: 6);
}
