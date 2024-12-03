import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/hooper_index_type.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/history/history.dart';
import 'package:physical_note/app/utils/utils.dart';

class AverageItem extends GetView<HistoryController> {
  const AverageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Obx(
            () => Expanded(
              child: _HooperIndexAvg(
                sleep: controller.avgData.value?.sleepAvg ?? 0,
                stress: controller.avgData.value?.stressAvg ?? 0,
                fatigue: controller.avgData.value?.fatigueAvg ?? 0,
                muscle: controller.avgData.value?.muscleSorenessAvg ?? 0,
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: UrineAndBodyFat(),
          ),
        ],
      ),
    );
  }
}

class _HooperIndexAvg extends StatelessWidget {
  final double sleep;
  final double stress;
  final double fatigue;
  final double muscle;

  const _HooperIndexAvg({
    required this.sleep,
    required this.stress,
    required this.fatigue,
    required this.muscle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringRes.hooperIndexAverage.tr,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: ColorRes.gray747474,
            letterSpacing: -0.7,
            height: 20 / 12,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _HooperIndexNames(),
            const SizedBox(width: 8),
            _HooperIndexValues(
              sleep: sleep,
              stress: stress,
              fatigue: fatigue,
              muscle: muscle,
            )
          ],
        )
      ],
    );
  }
}

class _HooperIndexNames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: HooperIndexType.values
          .map(
            (type) => Text(
              type.toString(),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: ColorRes.fontBlack,
                height: 2,
                letterSpacing: -0.5,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _HooperIndexValues extends StatelessWidget {
  final double sleep;
  final double stress;
  final double fatigue;
  final double muscle;

  const _HooperIndexValues({
    required this.sleep,
    required this.stress,
    required this.fatigue,
    required this.muscle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HooperIndexValue(value: sleep),
        _HooperIndexValue(value: stress),
        _HooperIndexValue(value: fatigue),
        _HooperIndexValue(value: muscle),
      ],
    );
  }
}

class _HooperIndexValue extends StatelessWidget {
  final double value;

  const _HooperIndexValue({
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: min(77, 11 * value),
          height: 8,
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: getBarColor(value.toInt()),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${value.toInt()}',
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: ColorRes.gray747474,
          ),
        ),
      ],
    );
  }

  Color getBarColor(int value) {
    return ColorUtils.convertWellness(value);
  }
}

class UrineAndBodyFat extends GetView<HistoryController> {
  const UrineAndBodyFat({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          _UrineAvgItem(
            text: StringRes.urineColor.tr,
            value: controller.avgData.value?.urineAvg ?? 0,
          ),
          _BodyFat(),
          const SizedBox(height: 10),
          _UrineAvgDescription(
            urine: controller.avgData.value?.urineAvg ?? 0,
            weight: controller.avgData.value?.weightAvg ?? 0,
          )
        ],
      ),
    );
  }
}

class _UrineAvgItem extends StatelessWidget {
  final String text;

  final double value;

  const _UrineAvgItem({
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: ColorRes.gray747474,
            height: 20 / 12,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            value.toStringAsFixed(2),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: ColorRes.fontBlack,
              height: 35 / 24,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _BodyFat extends GetView<HistoryController> {
  double get value => controller.avgData.value?.weightAvg ?? 0;

  String get percent => controller.avgData.value?.differenceFat ?? '-';

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Text(
            StringRes.bodyFat.tr,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: ColorRes.gray747474,
              height: 20 / 12,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(width: 7),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: value.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: ColorRes.fontBlack,
                    height: 35 / 24,
                    letterSpacing: -0.5,
                  ),
                ),
                TextSpan(
                  text: StringRes.kg.tr,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: ColorRes.fontBlack,
                    height: 35 / 24,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Text(
            "($percent%)",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: ColorRes.fontBlack,
              height: 35 / 24,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _UrineAvgDescription extends StatelessWidget {
  final double urine;
  final double weight;

  const _UrineAvgDescription({
    required this.urine,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(Assets.exclamationMark),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            _getDescription(urine, weight),
            softWrap: true,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: ColorRes.fontBlack,
              height: 14 / 10,
              letterSpacing: -0.5,
            ),
          ),
        ),
      ],
    );
  }

  /// 수분 섭취 설명
  String _getDescription(double urine, double weight) {
    if (urine >= 1 && urine <= 3) {
      if (weight < -2) {
        return StringRes.urineWeightLessMoistureGood.tr;
      } else if (weight > 2) {
        return StringRes.urineWeightOverMoistureGood.tr;
      } else {
        return StringRes.urineWeightGoodMoistureGood.tr;
      }
    } else if(urine > 3 && urine <= 7) {
      if (weight < -2) {
        return StringRes.urineWeightLessMoistureBad.tr;
      } else if (weight > 2) {
        return StringRes.urineWeightOverMoistureBad.tr;
      } else {
        return StringRes.urineWeightGoodMoistureBad.tr;
      }
    } else {
      return '';
    }
  }
}
