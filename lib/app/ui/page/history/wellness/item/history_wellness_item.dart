import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'history_wellness_item_ui_state.dart';

/// 웰리니스 목록 아이템
class HistoryWellnessItem extends StatelessWidget {
  final HistoryWellnessItemUiState uiState;

  final bool isFirst;

  final VoidCallback onPressed;

  const HistoryWellnessItem({
    super.key,
    required this.uiState,
    this.isFirst = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => isFirst
      ? Column(
          children: [
            _Average(
              sleep: (uiState.sleepAvg ?? 0).toInt(),
              stress: (uiState.stressAvg ?? 0).toInt(),
              fatigue: (uiState.fatigueAvg ?? 0).toInt(),
              musclePain: (uiState.muscleSorenessAvg ?? 0).toInt(),
              urine: uiState.urineAvg,
              weight: uiState.weightAvg,
            ),
            const SizedBox(height: 24),
            _Content(
              uiState: uiState,
              onPressed: onPressed,
            ),
          ],
        )
      : _Content(
          uiState: uiState,
          onPressed: onPressed,
        );
}

class _Average extends StatelessWidget {
  final int sleep;

  final int stress;

  final int fatigue;

  final int musclePain;

  final double? urine;

  final double? weight;

  const _Average({
    required this.sleep,
    required this.stress,
    required this.fatigue,
    required this.musclePain,
    required this.urine,
    required this.weight,
  });

  String get urineText => urine?.toStringAsFixed(1) ?? '-';

  String get weightText => weight?.toStringAsFixed(1) ?? '-';

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringRes.hooperIndexAverage.tr,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorRes.fontBlack,
                    letterSpacing: -0.7),
              ),
              const SizedBox(height: 8),
              _AverageHooperIndexItem(
                text: StringRes.sleepNoSpace.tr,
                value: sleep,
              ),
              _AverageHooperIndexItem(
                text: StringRes.stress.tr,
                value: stress,
              ),
              _AverageHooperIndexItem(
                text: StringRes.fatigue.tr,
                value: fatigue,
              ),
              _AverageHooperIndexItem(
                text: StringRes.musclePain.tr,
                value: 3,
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringRes.urinalysisAverage.tr,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorRes.fontBlack,
                    letterSpacing: -0.7),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _AverageUrinalysisItem(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    svgAsset: Assets.wellnessWater,
                    value: urineText,
                    valueSuffix: '',
                    description: '수분섭취가 부족합니다.',
                  ),
                  const SizedBox(width: 20),
                  _AverageUrinalysisItem(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    svgAsset: Assets.wellnessWeightGreen,
                    value: weightText,
                    valueSuffix: 'kg',
                    description: '체중조절이 필요합니다.',
                  ),
                ],
              )
            ],
          ),
        ],
      );
}

class _AverageHooperIndexItem extends StatelessWidget {
  final String text;

  final int value;

  const _AverageHooperIndexItem({
    required this.text,
    required this.value,
  });

  String get _emptyText =>
      List<String>.generate(4 - text.length, (i) => '빈').join('');

  Color get barColor => ColorUtils.convertWellness(value);

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: ColorRes.fontBlack,
              height: 2,
            ),
          ),
          Text(
            _emptyText,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.transparent,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: min(77, 11 * value.toDouble()),
            height: 5,
            decoration: BoxDecoration(
              color: barColor,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: ColorRes.fontBlack,
            ),
          ),
        ],
      );
}

class _AverageUrinalysisItem extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;

  final String svgAsset;

  final String value;

  final String valueSuffix;

  final String description;

  const _AverageUrinalysisItem({
    required this.crossAxisAlignment,
    required this.svgAsset,
    required this.value,
    required this.valueSuffix,
    required this.description,
  });

  @override
  Widget build(BuildContext context) => IntrinsicWidth(
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            SvgPicture.asset(svgAsset),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: ColorRes.fontBlack,
                    letterSpacing: -1,
                  ),
                ),
                Text(
                  valueSuffix,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: ColorRes.fontBlack,
                  ),
                ),
              ],
            ),
            Text(
              description,
              style: const TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w400,
                color: ColorRes.grayBababa,
              ),
            ),
          ],
        ),
      );
}

class _Content extends StatelessWidget {
  final HistoryWellnessItemUiState uiState;

  final VoidCallback onPressed;

  const _Content({
    required this.uiState,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => InkWellOver(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 8,
                  offset: const Offset(0, 4), // changes position of shadow
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    uiState.recordDate,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorRes.gray9f9f9f,
                      letterSpacing: -0.7,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _HooperIndexItem(
                        label: StringRes.sleep.tr,
                        value: uiState.sleep ?? 0,
                      ),
                      const SizedBox(width: 7),
                      _HooperIndexItem(
                        label: StringRes.fatigue.tr,
                        value: uiState.fatigue ?? 0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      _HooperIndexItem(
                        label: StringRes.stress.tr,
                        value: uiState.stress ?? 0,
                      ),
                      const SizedBox(width: 7),
                      _HooperIndexItem(
                        label: StringRes.musclePain.tr,
                        value: uiState.muscleSoreness ?? 0,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              _Urine(urine: uiState.urine),
              const Spacer(),
              _Weight(weight: uiState.emptyStomachWeight),
            ],
          ),
        ),
      );
}

class _Circle extends StatelessWidget {
  final Color? color;

  const _Circle({this.color});

  @override
  Widget build(BuildContext context) => Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
      );
}

class _HooperIndexItem extends StatelessWidget {
  final String label;

  final int value;

  const _HooperIndexItem({
    required this.label,
    required this.value,
  });

  // 원형 색상
  Color get circleColor => ColorUtils.convertWellness(value);

  final _textStyle = const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: ColorRes.fontBlack,
  );

  @override
  Widget build(BuildContext context) => Row(
        children: [
          _Circle(color: circleColor),
          const SizedBox(width: 6),
          Text('$label($value)', style: _textStyle),
          const SizedBox(width: 7),
        ],
      );
}

class _Urine extends StatelessWidget {
  final int? urine;

  const _Urine({required this.urine});

  String get text => urine == null
      ? '-'
      : urine! > 3
          ? '부족'
          : '양호';

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 46,
        height: 63,
        child: Stack(
          children: [
            Positioned.fill(
                child: SvgPicture.asset(
              Assets.wellnessUrine,
            )),
            Positioned(
              top: 17,
              left: 0,
              right: 0,
              child: Text(
                '$urine',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.gray9f9f9f,
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.gray9f9f9f,
                ),
              ),
            ),
          ],
        ),
      );
}

class _Weight extends StatelessWidget {
  final double? weight;

  const _Weight({required this.weight});

  String get text => weight == null ? '-kg' : '$weight';

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 76,
        height: 67,
        child: Stack(
          children: [
            Positioned.fill(
                child: SvgPicture.asset(
              Assets.wellnessWeight,
            )),
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: ColorRes.gray9f9f9f,
                    ),
                  ),
                  Text(
                    StringRes.kg.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: ColorRes.gray9f9f9f,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
