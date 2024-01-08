import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/photo_model.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/my_information/my_information.dart';
import 'package:physical_note/app/ui/page/my_information/position/position_list_item_ui_state.dart';
import 'package:physical_note/app/ui/widgets/buttons/hint_button.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

/// 내정보 뷰.
class MyInformationPage extends GetView<MyInformationController> {
  const MyInformationPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _Header(),
              _Profile(),
              _Name(),
              const SizedBox(height: 20),
              _Team(),
              const SizedBox(height: 10),
              _Elite(),
              const SizedBox(height: 20),
              _HeightWeight(),
              const SizedBox(height: 20),
              _BirthAndGender(),
              const SizedBox(height: 20),
              _Position(),
              const SizedBox(height: 20),
              _MainFooted(),
              const SizedBox(height: 20),
              Obx(
                () => RoundButton(
                  width: double.infinity,
                  text: StringRes.registration.tr,
                  isEnabled: controller.isEnabledRegistrationButton.value,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: ColorRes.white,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  onPressed: controller.onPressedRegistration,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      );
}

/// 헤더.
class _Header extends GetView<MyInformationController> {
  @override
  Widget build(BuildContext context) => Header(
        title: StringRes.myInformation.tr,
        showBack: true,
        onPressed: controller.close,
        menu: LabelButton(
          text: StringRes.logout.tr,
          onPressed: controller.logout,
        ),
      );
}

/// 필드명.
class FieldName extends StatelessWidget {
  final String name;

  const FieldName({super.key, required this.name});

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.centerLeft,
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
}

/// 프로필 이미지.
class _Profile extends GetView<MyInformationController> {
  @override
  Widget build(BuildContext context) => Stack(
        clipBehavior: Clip.none,
        children: [
          Obx(
            () => Container(
              height: 92,
              width: 92,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: ColorRes.white,
                borderRadius: BorderRadius.circular(46),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: _ProfileImage(
                photoData: controller.profile.value,
              ),
            ),
          ),
          Positioned(
              bottom: -10,
              right: -10,
              child: InkWellOver(
                borderRadius: BorderRadius.circular(19),
                child: Container(
                  width: 38,
                  height: 38,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    color: ColorRes.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(Assets.camera),
                ),
                onTap: () async {
                  await controller.onTapProfile(context);
                },
              )),
        ],
      );
}

/// 프로필 이미지.
class _ProfileImage extends StatelessWidget {
  final PhotoModel photoData;

  const _ProfileImage({required this.photoData});

  @override
  Widget build(BuildContext context) {
    if (photoData.imageUrl != null) {
      return Image.network(
        photoData.imageUrl ?? "",
        fit: BoxFit.fitWidth,
        errorBuilder: (
          BuildContext context,
          Object error,
          StackTrace? stackTrace,
        ) {
          return SvgPicture.asset(Assets.userDefault);
        },
      );
    } else if (photoData.file != null) {
      return Image.file(
        File(photoData.file?.path ?? ""),
        fit: BoxFit.fitWidth,
        errorBuilder: (
          BuildContext context,
          Object error,
          StackTrace? stackTrace,
        ) {
          return SvgPicture.asset(Assets.userDefault);
        },
      );
    } else {
      return SvgPicture.asset(Assets.userDefault);
    }
  }
}

/// 이름.
class _Name extends GetView<MyInformationController> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          FieldName(name: StringRes.name.tr),
          const SizedBox(height: 10),
          OutlineTextField(
            controller: controller.name.controller,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            hint: StringRes.nameHint.tr,
            readOnly: true,
          ),
        ],
      ).paddingSymmetric(horizontal: 30);
}

/// 팀명.
class _Team extends GetView<MyInformationController> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          FieldName(name: StringRes.teamName.tr),
          const SizedBox(height: 10),
          Obx(
            () => HintButton(
              text: controller.teamUiState.value?.clubAndCoach ?? "",
              hint: StringRes.selectTeam.tr,
              onTap: () async {
                controller.onPressedTeamName();
              },
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 30);
}

/// 엘리트, 아마추어 여부
class _Elite extends GetView<MyInformationController> {
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Obx(
              () => RoundButton(
                text: StringRes.amateur.tr,
                isSelected: controller.isElite.value == false,
                backgroundColor: ColorRes.white,
                selectedColor: ColorRes.primary,
                textStyle: const TextStyle(
                  color: ColorRes.fontBlack,
                  fontSize: 16,
                ),
                selectedTextStyle: const TextStyle(
                  color: ColorRes.fontBlack,
                  fontSize: 16,
                ),
                border: Border.all(color: ColorRes.borderDeselect),
                onPressed: () => controller.onPressedElite(false),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Obx(
              () => RoundButton(
                text: StringRes.elite.tr,
                isEnabled: true,
                isSelected: controller.isElite.value == true,
                backgroundColor: ColorRes.white,
                selectedColor: ColorRes.primary,
                textStyle: const TextStyle(
                  color: ColorRes.fontBlack,
                  fontSize: 16,
                ),
                selectedTextStyle: const TextStyle(
                  color: ColorRes.fontBlack,
                  fontSize: 16,
                ),
                border: Border.all(color: ColorRes.borderDeselect),
                onPressed: () => controller.onPressedElite(true),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 30);
}

/// 키.
class _Height extends GetView<MyInformationController> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          FieldName(name: StringRes.height.tr),
          const SizedBox(height: 10),
          OutlineTextField(
            controller: controller.height.controller,
            keyboardType: TextInputType.number,
            rightWidget: Text(
              StringRes.cm.tr,
              style: const TextStyle(
                fontSize: 16,
                color: ColorRes.disable,
              ),
            ),
          ),
        ],
      );
}

/// 몸무게.
class _Weight extends GetView<MyInformationController> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          FieldName(name: StringRes.weight.tr),
          const SizedBox(height: 10),
          OutlineTextField(
            controller: controller.weight.controller,
            keyboardType: TextInputType.number,
            rightWidget: Text(
              StringRes.kg.tr,
              style: const TextStyle(
                fontSize: 16,
                color: ColorRes.disable,
              ),
            ),
          ),
        ],
      );
}

/// 키와 몸무게.
class _HeightWeight extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(child: _Height()),
          const SizedBox(width: 20),
          Expanded(child: _Weight()),
        ],
      ).paddingSymmetric(horizontal: 30);
}

/// 생년월일.
class _Birth extends GetView<MyInformationController> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          FieldName(name: StringRes.birth.tr),
          const SizedBox(height: 10),
          OutlineTextField(
            controller: controller.birth.controller,
            keyboardType: TextInputType.number,
            maxLength: 8,
            readOnly: true,
          ),
        ],
      );
}

/// 성별.
class _Gender extends GetView<MyInformationController> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          FieldName(name: StringRes.gender.tr),
          const SizedBox(height: 10),
          OutlineTextField(
            controller: controller.gender.controller,
            readOnly: true,
          ),
        ],
      );
}

/// 생년월일, 성별.
class _BirthAndGender extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(child: _Birth()),
          const SizedBox(width: 20),
          Expanded(child: _Gender()),
        ],
      ).paddingSymmetric(horizontal: 30);
}

/// 포지션.
class _Position extends GetView<MyInformationController> {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringRes.positionMultipleSelectionPossible.tr,
              style: const TextStyle(
                fontSize: 16,
                color: ColorRes.fontBlack,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            HintButton(
              hint: StringRes.pushSelect.tr,
              text: "",
              onTap: controller.onPressedSearchPosition,
            ),
            const SizedBox(height: 10),
            Obx(
              () => Wrap(
                spacing: 5,
                runSpacing: 10,
                children: [
                  ..._positionList(controller.positions),
                  Visibility(
                    visible: controller.positions.isNotEmpty,
                    child: InkWellOver(
                      onTap: controller.onPressedSearchPosition,
                      splashColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SvgPicture.asset(Assets.plusGreen),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  List<Widget> _positionList(List<PositionListItemUiState> list) {
    List<Widget> positionWidgets = list
        .map(
          (element) => FittedBox(
            child: Stack(
              children: [
                Container(
                  height: 36,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.center,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorRes.primary,
                    border: Border.all(color: ColorRes.border),
                  ),
                  child: Text(
                    element.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      color: ColorRes.fontBlack,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWellOver(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      controller.onPressedPositionDeleteButton(element);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.clear,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();

    return positionWidgets;
  }
}

/// 주 발.
class _MainFooted extends GetView<MyInformationController> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          FieldName(name: StringRes.mainFoot.tr),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  StringRes.leftFoot.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    color: ColorRes.fontDisable,
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: ColorRes.primary,
                      inactiveTrackColor: ColorRes.disable,
                      trackShape: const RoundedRectSliderTrackShape(),
                      trackHeight: 6.0,
                      thumbShape: const RoundSliderThumbShape(),
                      thumbColor: ColorRes.primary,
                      overlayColor: ColorRes.primary.withAlpha(32),
                      overlayShape: SliderComponentShape.noOverlay,
                      tickMarkShape: const RoundSliderTickMarkShape(),
                      activeTickMarkColor: Colors.transparent,
                      inactiveTickMarkColor: Colors.transparent,
                      valueIndicatorShape:
                          const PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: ColorRes.primary,
                      valueIndicatorTextStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    child: Slider(
                      value: controller.leftFoot.value,
                      min: 0.0,
                      max: 10.0,
                      divisions: 10,
                      label: '${controller.leftFoot.round()}',
                      onChanged: (double newValue) {
                        controller.onChangeLeftFoot(newValue);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  StringRes.rightFoot.tr,
                  style: const TextStyle(
                    fontSize: 16,
                    color: ColorRes.fontDisable,
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: ColorRes.primary,
                      inactiveTrackColor: ColorRes.disable,
                      trackShape: const RoundedRectSliderTrackShape(),
                      trackHeight: 6.0,
                      thumbShape: const RoundSliderThumbShape(),
                      thumbColor: ColorRes.primary,
                      overlayColor: ColorRes.primary.withAlpha(32),
                      overlayShape: SliderComponentShape.noOverlay,
                      tickMarkShape: const RoundSliderTickMarkShape(),
                      activeTickMarkColor: Colors.transparent,
                      inactiveTickMarkColor: Colors.transparent,
                      valueIndicatorShape:
                          const PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: ColorRes.primary,
                      valueIndicatorTextStyle: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    child: Slider(
                      value: controller.rightFoot.value,
                      min: 0.0,
                      max: 10.0,
                      divisions: 10,
                      label: '${controller.rightFoot.round()}',
                      onChanged: (double newValue) {
                        controller.onChangeRightFoot(newValue);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 30);
}
