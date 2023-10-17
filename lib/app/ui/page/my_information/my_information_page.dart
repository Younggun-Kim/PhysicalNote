import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/my_information/my_information.dart';
import 'package:physical_note/app/ui/widgets/buttons/hint_button.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

/// 내정보 뷰.
class MyInformationPage extends GetView<MyInformationController> {
  const MyInformationPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: Column(
          children: [
            _Header(),
            _Name(),
            const SizedBox(height: 20),
            _Team(),
            const SizedBox(height: 20),
          ],
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
