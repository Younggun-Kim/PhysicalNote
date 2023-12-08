import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

import 'home_injury_check_item_ui_state.dart';

class HomeInjuryCheckItem extends StatelessWidget {
  final HomeInjuryCheckItemUiState uiState;

  const HomeInjuryCheckItem({
    super.key,
    required this.uiState,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _Level(level: uiState.level),
              const SizedBox(width: 10),
              Text(
                uiState.muscleName ?? "",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if((uiState.muscleName ?? "").isNotEmpty)
                const SizedBox(width: 10),
              Text(
                uiState.recordDate ?? "",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 10),
              InkWellOver(
                onTap: () {},
                child: SvgPicture.asset(
                  Assets.edit03,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            uiState.description ?? "",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16),
        ],
      );
}

class _Level extends StatelessWidget {
  /// Level - 0 ~ 5 단게 / other = 질병.
  final int? level;

  const _Level({required this.level});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: levelToBorderColor(level),
          ),
          color: levelToBackgroundColor(level),
        ),
        child: Text(
          levelToString(level),
          style: TextStyle(
            fontSize: 14,
            color: levelToFontColor(level),
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  /// Level 문자열로 변경.
  String levelToString(int? level) {
    if (level != null && level >= 0 && level <= 5) {
      return "$level단계";
    } else {
      return "질병";
    }
  }

  /// Level 백그라운드 색상.
  Color levelToBackgroundColor(int? level) {
    if (level == 0) {
      return ColorRes.intensity0;
    } else if (level == 1) {
      return ColorRes.intensity1;
    } else if (level == 2) {
      return ColorRes.intensity2;
    } else if (level == 3) {
      return ColorRes.intensity3;
    } else if (level == 4) {
      return ColorRes.intensity4;
    } else if (level == 5) {
      return ColorRes.intensity5;
    } else {
      return ColorRes.disable;
    }
  }

  /// Level 테두리 색상.
  Color levelToBorderColor(int? level) {
    if (level == 0) {
      return ColorRes.intensityLine0;
    } else if (level == 1) {
      return ColorRes.intensityLine1;
    } else if (level == 2) {
      return ColorRes.intensityLine2;
    } else if (level == 3) {
      return ColorRes.intensityLine3;
    } else if (level == 4) {
      return ColorRes.intensityLine4;
    } else if (level == 5) {
      return ColorRes.intensityLine5;
    } else {
      return ColorRes.borderDeselect;
    }
  }

  /// Level 폰트 색상.
  Color levelToFontColor(int? level) {
    if (level != null && level < 3) {
      return ColorRes.fontBlack;
    } else {
      return ColorRes.white;
    }
  }
}
