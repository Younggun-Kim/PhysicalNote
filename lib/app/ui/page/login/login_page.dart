import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/login/login_controller.dart';
import 'package:physical_note/app/ui/widgets/buttons/round_button.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';
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
            const _PasswordField(),
            const SizedBox(height: 40),
            const _SignUpAndFindField(),
            RoundButton(
              text: StringRes.login.tr,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              textStyle: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              onPressed: controller.onPressedLogin,
            ),

            const SizedBox(height: 40),
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
          hint: StringRes.emailHint.tr,
          keyboardType: TextInputType.emailAddress,
        ).paddingSymmetric(horizontal: 20),
        const SizedBox(height: 10),
        Obx(
          () => _ErrorText(
              message: StringRes.emailError.tr,
              visible: controller.isValidEmail.value),
        ),
      ],
    );
  }
}

/// 비밀번호 필드.
class _PasswordField extends GetView<LoginController> {
  const _PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          OutlineTextField(
            controller: controller.password.controller,
            hint: StringRes.passwordHint.tr,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          ).paddingSymmetric(horizontal: 20),
          const SizedBox(height: 10),
          Obx(
            () => _ErrorText(
                message: StringRes.passwordError.tr,
                visible: controller.isValidEmail.value),
          ),
        ],
      );
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        alignment: Alignment.centerLeft,
        child: Text(
          message,
          style: const TextStyle(
            color: ColorRes.fontError,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

/// 가입 및 찾기 필드.
class _SignUpAndFindField extends GetView<LoginController> {
  const _SignUpAndFindField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BaseTextButton(
          text: StringRes.simpleSignUp.tr,
          textStyle: const TextStyle(
            color: ColorRes.fontBlack,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          onPressed: controller.onPressedSimpleSignUp,
        ),
        const Spacer(),
        BaseTextButton(
          text: StringRes.findId.tr,
          textStyle: const TextStyle(
            color: ColorRes.fontDisable,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          onPressed: controller.onPressedSimpleSignUp,
        ),
        const SizedBox(width: 4),
        Container(
          width: 1,
          height: 14,
          color: ColorRes.borderWhite,
        ),
        const SizedBox(width: 4),
        BaseTextButton(
          text: StringRes.findPw.tr,
          textStyle: const TextStyle(
            color: ColorRes.fontDisable,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          onPressed: controller.onPressedSimpleSignUp,
        ),
      ],
    ).paddingSymmetric(horizontal: 20);
  }
}
