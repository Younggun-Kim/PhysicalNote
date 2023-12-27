import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:physical_note/app/config/constant/injury_level_type.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
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
              _Level(
                injuryLevelType: uiState.injuryLevelType,
              ),
              const SizedBox(width: 10),
              if (uiState.muscleType != null)
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    uiState.muscleType?.rawValue ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              else
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
          Visibility(
            visible: uiState.injuryType != InjuryType.disease,
            child: Row(
              children: [
                Text(
                  "${uiState.injuryType?.toString() ?? ""}(${uiState.injuryLevelTypeString})",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.fontBlack,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: uiState.injuryType != InjuryType.disease,
            child: Row(
              children: [
                Text(
                  uiState.injuryLevelType.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ColorRes.fontBlack,
                  ),
                ),
              ],
            ),
          ),
          Text(
            _comment(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
        ],
      );

  /// 코멘트 문자열.
  String _comment() {
    final comment = uiState.comment ?? "";
    final colons = uiState.injuryType == InjuryType.disease ? "" : ": ";
    return "$colons$comment";
  }
}

class _Level extends StatelessWidget {
  final InjuryLevelType? injuryLevelType;

  const _Level({
    required this.injuryLevelType,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: injuryLevelType?.toBorderColor() ?? ColorRes.borderDeselect,
          ),
          color: injuryLevelType?.toBackgroundColor() ?? ColorRes.disable,
        ),
        child: Text(
          levelString(),
          style: TextStyle(
            fontSize: 14,
            color: injuryLevelType?.toFontColor() ?? ColorRes.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  String levelString() {
    final level = injuryLevelType?.toLevel();

    if (level == null) {
      return "질병";
    } else {
      return "$level단계";
    }
  }
}
