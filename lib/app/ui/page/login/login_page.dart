import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/login/login_controller.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

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
            const SizedBox(height: 75),
            SvgPicture.asset(Assets.logo),
            const SizedBox(height: 75),
            const _EmailField(),
            const SizedBox(height: 20),
            const _PasswordField(),
            const SizedBox(height: 40),
            const _SignUpAndFindField(),
            const SizedBox(height: 7),
            const LoginButton(),
            const SizedBox(height: 30),
            _SnsField(),
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
        ).paddingSymmetric(horizontal: 30),
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
          ).paddingSymmetric(horizontal: 30),
          const SizedBox(height: 10),
          Obx(
            () => _ErrorText(
                message: StringRes.passwordError.tr,
                visible: controller.isValidPassword.value),
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
        padding: const EdgeInsets.symmetric(horizontal: 46),
        alignment: Alignment.centerLeft,
        child: Text(
          message,
          style: const TextStyle(
            color: ColorRes.error,
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
        LabelButton(
          text: StringRes.simpleSignUp.tr,
          textStyle: const TextStyle(
            color: ColorRes.fontBlack,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          onPressed: controller.onPressedSimpleSignUp,
        ),
        const Spacer(),
        LabelButton(
          text: StringRes.findId.tr,
          textStyle: const TextStyle(
            color: ColorRes.fontDisable,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          onPressed: controller.onPressedFindId,
        ),
        const SizedBox(width: 4),
        Container(
          width: 1,
          height: 14,
          color: ColorRes.borderWhite,
        ),
        const SizedBox(width: 4),
        LabelButton(
          text: StringRes.findPw.tr,
          textStyle: const TextStyle(
            color: ColorRes.fontDisable,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          onPressed: controller.onPressedFindPw,
        ),
      ],
    ).paddingSymmetric(horizontal: 20);
  }
}

/// 로그인 버튼.
class LoginButton extends GetView<LoginController> {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) => Obx(() => RoundButton(
        text: StringRes.login.tr,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: null,
        textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
        isEnabled: controller.isEnabledLogin.value,
        onPressed: controller.onPressedLogin,
      ));
}

/// Sns로 시작하기 뷰.
class _SnsField extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              StringRes.startWithSns.tr,
              style: const TextStyle(
                fontSize: 12,
                color: ColorRes.fontBlack,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWellOver(
                  onTap: controller.onPressedNaver,
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    Assets.imgNaver,
                    width: 44,
                    height: 44,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 24),
                InkWellOver(
                  onTap: controller.onPressedKakao,
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    Assets.imgKakao,
                    width: 44,
                    height: 44,
                    fit: BoxFit.contain,
                  ),
                ),
                Visibility(visible: Platform.isIOS, child: _apple())
              ],
            ),
          ],
        ),
      );

  /// Apple 로그인 뷰.
  Widget _apple() => Row(
        children: [
          const SizedBox(width: 24),
          InkWellOver(
            onTap: controller.onPressedApple,
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              Assets.imgApple,
              width: 44,
              height: 44,
              fit: BoxFit.contain,
            ),
          ),
        ],
      );
}
