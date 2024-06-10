import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/data/data.dart';
import 'package:physical_note/app/ui/page/data/injury/injury_menu_type.dart';
import 'package:physical_note/app/ui/page/home/item/home_injury_check_item/home_injury_check_item.dart';
import 'package:physical_note/app/ui/page/injury_check/injury_check.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

import 'injury_recovery_button.dart';

class InjuryPage extends GetView<DataController> {
  const InjuryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => FlexibleScrollView(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 24),
        child: Stack(
          children: [
            Obx(
              () => Visibility(
                visible:
                    controller.currentInjuryMenu.value == InjuryMenuType.check,
                child: _InjuryCheck(),
              ),
            ),
            Obx(
              () => Visibility(
                visible: controller.currentInjuryMenu.value ==
                    InjuryMenuType.history,
                child: _InjuryHistory(),
              ),
            ),
          ],
        ),
      );
}

/// 부상 이력
class _InjuryHistory extends GetView<DataController> {
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24), // Top Padding
          Row(
            children: [
              Text(
                StringRes.injuryHistory.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: ColorRes.fontBlack,
                ),
              ),
              const Spacer(),
              Obx(
                () => InjuryRecoveryButton(
                  type: controller.injuryRecoveryType.value,
                  onPressed: controller.onPressedInjuryStateType,
                ),
              ),
            ],
          ),
          Text(
            StringRes.injuryHistoryDescription.tr,
            style: const TextStyle(
              fontSize: 12,
              color: ColorRes.fontDisable,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 528 / 1205,
                  child: Obx(() =>
                      SvgPicture.string(controller.humanFrontImage.value)),
                ),
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 528 / 1205,
                  child: Obx(
                      () => SvgPicture.string(controller.humanBackImage.value)),
                ),
              ),
            ],
          ),
          Obx(() {
            final uiStates = controller.injuryList.toList();
            if (uiStates.isEmpty) {
              return const SizedBox();
            } else {
              return Column(
                children: List<Widget>.generate(uiStates.length, (index) {
                  return HomeInjuryCheckItem(
                      uiState: uiStates[index],
                      isShowBorder: true,
                      onPressedEdit: () {
                        controller.onPressedEdit(uiStates[index]);
                      });
                }).toList(),
              );
            }
          }),
        ],
      );
}

/// 부상 체크
class _InjuryCheck extends GetView<DataController> {
  @override
  Widget build(BuildContext context) => const InjuryCheckPage();
}
