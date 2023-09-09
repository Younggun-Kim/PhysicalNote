import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/login/login_controller.dart';
import 'package:physical_note/app/ui/widgets/outline_text_field.dart';
import 'package:physical_note/app/utils/base/widget/page_root.dart';

import '../../../resources/resources.dart';

/// 로그인 화면.
class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 100),
            Text(
              StringRes.appName.tr,
              style: const TextStyle(
                  fontSize: 30,
                  color: ColorRes.primary,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 100),
            const _EmailField(),
            const SizedBox(height: 20),
            OutlineTextField(
              controller: controller.passwordController,
              hint: "password",
            ).paddingSymmetric(horizontal: 20),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/// 이메일 필드.
class _EmailField extends GetView<LoginController> {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlineTextField(
          controller: controller.email.controller,
          hint: "email",
        ).paddingSymmetric(horizontal: 20),
        Obx(
          () => _ErrorText(
              message: "바른  이메일을 입력해주세요",
              visible: controller.isValidEmail.value),
        ),
      ],
    );
  }
}

/// 에러 문구.
class _ErrorText extends StatelessWidget {
  final String message;
  final bool visible;

  const _ErrorText({
    required this.message,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Text(message),
    );
  }
}
