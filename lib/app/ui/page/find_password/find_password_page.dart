import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/find_password/find_password.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

class FindPasswordPage extends GetView<FindPasswordController> {
  const FindPasswordPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: FlexibleScrollView(
          child: Column(
            children: [
              _Header(),
              const SizedBox(height: 20),
              const NameField(),
              const SizedBox(height: 36),
              const EmailField(),
              const SizedBox(height: 20),
              const Spacer(),
              Obx(
                () => RoundButton(
                  width: double.infinity,
                  text: StringRes.next.tr,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  isEnabled: controller.isEnabledNext.value,
                  onPressed: controller.onPressedNext,
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

/// 헤더.
class _Header extends GetView<FindPasswordController> {
  @override
  Widget build(BuildContext context) => Header(
        title: StringRes.findPw.tr,
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
class NameField extends GetView<FindPasswordController> {
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

/// 이메일 번호 필드.
class EmailField extends GetView<FindPasswordController> {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          FieldName(name: StringRes.email.tr),
          const SizedBox(height: 10),
          OutlineTextField(
            controller: controller.email.controller,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            hint: StringRes.emailHint.tr,
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ).paddingSymmetric(horizontal: 30);
}
