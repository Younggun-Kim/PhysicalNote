import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/buttons/base_button.dart';

import 'injury_state_type.dart';

class InjuryStateButton extends StatelessWidget {
  final InjuryStateType type;

  final Function(InjuryStateType) onPressed;

  const InjuryStateButton({
    super.key,
    required this.type,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: ColorRes.secondPrimary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            _InjuryStateButtonItem(
              text: StringRes.progress.tr,
              isSelected: type == InjuryStateType.progress,
              onPressed: () {
                onPressed(InjuryStateType.progress);
              },
            ),
            _InjuryStateButtonItem(
              text: StringRes.recovery.tr,
              isSelected: type == InjuryStateType.recovery,
              onPressed: () {
                onPressed(InjuryStateType.recovery);
              },
            ),
          ],
        ),
      );
}

class _InjuryStateButtonItem extends StatelessWidget {
  final String text;

  final bool isSelected;

  final Function() onPressed;

  const _InjuryStateButtonItem({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => BaseButton(
        text: text,
        isSelected: isSelected,
        defaultBackgroundColor: Colors.transparent,
        selectedBackgroundColor: Colors.white,
        showBorder: false,
        showShadow: false,
        defaultTextStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: ColorRes.gray9f9f9f,
        ),
        selectedTextStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: ColorRes.fontBlack,
        ),
        onPressed: onPressed,
      );
}
