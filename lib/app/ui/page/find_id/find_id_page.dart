import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/find_id/find_id_controller.dart';
import 'package:physical_note/app/ui/widgets/buttons/round_button.dart';

import '../../widgets/widgets.dart';

/// 아이디 찾기 화면.
class FindIdPage extends GetView<FindIdController> {
  const FindIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      child: FlexibleScrollView(
        child: Column(
          children: [
            _Header(),
            const SizedBox(height: 20),
            const NameField(),
            const SizedBox(height: 36),
            const PhoneNumberField(),
            const SizedBox(height: 20),
            const Spacer(),
            Obx(
              () => RoundButton(
                width: double.infinity,
                text: StringRes.login.tr,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                isEnabled: controller.isEnabledLogin.value,
                onPressed: controller.onPressedLogin,
                textStyle: const TextStyle(
                  color: ColorRes.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

/// 헤더.
class _Header extends GetView<FindIdController> {
  @override
  Widget build(BuildContext context) => Header(
        title: StringRes.findId.tr,
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

/// 이름 필드.
class NameField extends GetView<FindIdController> {
  const NameField({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          /// 이름.
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

/// 휴대폰 번호 필드.
class PhoneNumberField extends GetView<FindIdController> {
  const PhoneNumberField({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          /// 휴대폰 번호.
          FieldName(name: StringRes.phoneNumber.tr),
          const SizedBox(height: 10),
          OutlineTextField(
            controller: controller.phoneNumber.controller,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            hint: StringRes.phoneHint.tr,
            keyboardType: TextInputType.phone,
            maxLength: 11,
          ),
        ],
      ).paddingSymmetric(horizontal: 30);
}
