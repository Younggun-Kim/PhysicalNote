import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';
import 'package:physical_note/app/utils/utils.dart';

import 'history_wellness_item_ui_state.dart';

/// 웰리니스 목록 아이템
class HistoryWellnessItem extends StatelessWidget {
  final HistoryWellnessItemUiState uiState;

  final VoidCallback onPressed;

  const HistoryWellnessItem({
    super.key,
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
                  color: Colors.grey.withValues(alpha:0.25),
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
                    LocalizationUtil.getDateStr(
                      date: uiState.recordDate,
                      koFormat: 'yy.MM.dd(EEE)',
                      enFormat: "MMMM dd, yy (E)",
                    ),
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
                      const SizedBox(width: 5),
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
                      const SizedBox(width: 5),
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
    letterSpacing: -0.5,
    height: 20 / 10,
  );

  @override
  Widget build(BuildContext context) => Row(
        children: [
          _Circle(color: circleColor),
          const SizedBox(width: 4),
          Text('$label($value)', style: _textStyle),
          const SizedBox(width: 4),
        ],
      );
}

class _Urine extends StatelessWidget {
  final int? urine;

  const _Urine({required this.urine});

  String get text => urine == null
      ? '-'
      : urine! > 3
          ? StringRes.drinkShortage.tr
          : StringRes.drinkGood.tr;

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

  int? get weightInt => weight?.toInt();

  String get text => weight == null ? '-kg' : '$weightInt';

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
