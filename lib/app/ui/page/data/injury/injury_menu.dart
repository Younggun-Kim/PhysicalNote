import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/data/injury/injury_menu_type.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

import '../data_controller.dart';

/// 부상 메뉴
class DataInjuryMenu extends GetView<DataController> {
  const DataInjuryMenu({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: (context.width - 60) / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorRes.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Column(
          children: [
            Obx(
              () => _InjuryMenuButton(
                text: StringRes.injuryCheck.tr,
                isSelected:
                    controller.currentInjuryMenu.value == InjuryMenuType.check,
                onPressed: () {
                  controller.onPressedInjuryMenu(InjuryMenuType.check);
                },
              ),
            ),
            const SizedBox(height: 4),
            Container(
              width: 86,
              height: 0.5,
              color: ColorRes.disable,
            ),
            const SizedBox(height: 4),
            Obx(
              () => _InjuryMenuButton(
                text: StringRes.injuryHistory.tr,
                isSelected: controller.currentInjuryMenu.value ==
                    InjuryMenuType.history,
                onPressed: () {
                  controller.onPressedInjuryMenu(InjuryMenuType.history);
                },
              ),
            ),
          ],
        ),
      );
}

/// 부상 메뉴 버튼
class _InjuryMenuButton extends StatelessWidget {
  final String text;

  final bool isSelected;

  final VoidCallback onPressed;

  const _InjuryMenuButton({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => LabelButton(
        text: text,
        textStyle: TextStyle(
          color: isSelected ? ColorRes.fontBlack : ColorRes.fontGray,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        onPressed: onPressed,
      );
}
