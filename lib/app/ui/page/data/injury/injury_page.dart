import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/data/data.dart';
import 'package:physical_note/app/ui/page/data/injury/injury_menu_type.dart';
import 'package:physical_note/app/ui/page/home/item/home_injury_check_item/home_injury_check_item.dart';
import 'package:physical_note/app/ui/page/injury_check/injury_check.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

import 'injury_state_button.dart';

class InjuryPage extends GetView<DataController> {
  const InjuryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: controller.closeInjuryMenu,
        child: FlexibleScrollView(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 24),
            child: Stack(
              children: [
                Obx(
                  () => Visibility(
                    visible: controller.currentInjuryMenu.value ==
                        InjuryMenuType.check,
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
                Positioned(
                  top: 0,
                  right: 0,
                  child: Obx(
                    () => Visibility(
                      visible: controller.isOpenInjuryMenu.value,
                      child: _InjuryMenu(),
                    ),
                  ),
                ),
              ],
            )),
      );
}

/// 부상 메뉴
class _InjuryMenu extends GetView<DataController> {
  @override
  Widget build(BuildContext context) => Container(
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
                () => InjuryStateButton(
                  type: controller.injuryStateType.value,
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
