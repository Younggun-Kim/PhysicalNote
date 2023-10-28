import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/my_information/my_information.dart';
import 'package:physical_note/app/ui/page/my_information/position/position_list_item.dart';
import 'package:physical_note/app/ui/widgets/buttons/hint_button.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';
import 'package:physical_note/app/utils/logger/logger.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

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
              _Name(),
              const SizedBox(height: 20),
              _Team(),
              const SizedBox(height: 20),
              _HeightWeight(),
              const SizedBox(height: 20),
              _BirthAndGender(),
              const SizedBox(height: 20),
              _Position(),
              const SizedBox(height: 20),
              _MainFooted(),
              const SizedBox(height: 20),
              RoundButton(
                width: double.infinity,
                text: StringRes.registration.tr,
                margin: const EdgeInsets.symmetric(horizontal: 30),
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
          HintButton(
            text: "",
            hint: StringRes.selectTeam.tr,
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
          OutlineRoundButton(
            width: double.infinity,
            text: controller.birth?.value.toString() ?? "",
            hint: StringRes.eightDigits.tr,
            fontSize: 16,
            onPressed: () {
              bottomSheetDatePicker(
                context,
                controller.onDateTimeChanged,
                controller.onPressedDateTimeChangeButton,
              );
            },
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
  Widget build(BuildContext context) => Column(
        children: [
          FieldName(name: StringRes.positionMultipleSelectionPossible.tr),
          const SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: Obx(
              () => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.positionItems.length,
                itemBuilder: (context, index) {
                  var uiState = controller.positionItems[index];
                  return PositionListItem(
                    uiState: uiState,
                    onTap: controller.onTapPositionItem,
                  );
                },
                separatorBuilder: (context, itemIndex) {
                  return const SizedBox(width: 5);
                },
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 30);
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
              Text(
                StringRes.leftFoot.tr,
                style: const TextStyle(
                  fontSize: 16,
                  color: ColorRes.fontDisable,
                ),
              ),
              Obx(
                () => Slider(
                  value: controller.leftFoot.value,
                  min: 0.0,
                  max: 100.0,
                  divisions: 10,
                  label: '${controller.leftFoot.round()}',
                  onChanged: (double newValue) {
                    controller.onChangeLeftFoot(newValue);
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                StringRes.rightFoot.tr,
                style: const TextStyle(
                  fontSize: 16,
                  color: ColorRes.fontDisable,
                ),
              ),
              Expanded(
                child: Obx(
                  () => SfSlider(
                    min: 0.0,
                    max: 10.0,
                    interval: 1,
                    showTicks: false,
                    showLabels: false,
                    enableTooltip: false,
                    minorTicksPerInterval: 1,
                    thumbIcon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.greenAccent, size: 20.0),
                    value: controller.rightFoot.value,
                    onChanged: (dynamic newValue) {
                      controller.onChangeRightFoot(newValue);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ).paddingSymmetric(horizontal: 30);
}
