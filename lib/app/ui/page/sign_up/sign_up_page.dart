import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/gender_type.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/sign_up/sign_up_controller.dart';

import '../../widgets/widgets.dart';

/// 회원가입 화면.
class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      child: Column(
        children: [
          _Header(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const NameField(),
                  const EmailField(),
                  const PhoneNumberField(),
                  const BirthField(),
                  const GenderField(),
                  const PasswordField(),
                  const SizedBox(height: 40),
                  Obx(() => RoundButton(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        isEnabled: controller.isEnabledLoginButton.value,
                        text: StringRes.login.tr,
                        onPressed: controller.onPressedLoginButton,
                      )),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 헤더.
class _Header extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) => Header(
        title: StringRes.signUp.tr,
        showBack: true,
        onPressed: controller.onPressedBackButton,
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

/// 에러 필드.
class ErrorText extends StatelessWidget {
  final String text;

  const ErrorText({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorRes.error,
          ),
        ),
      );
}

/// 이름 필드.
class NameField extends GetView<SignUpController> {
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
            readOnly: false,
          ),
        ],
      ).paddingSymmetric(horizontal: 30);
}

/// 이메일 필드.
class EmailField extends GetView<SignUpController> {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          /// 이메일.
          const SizedBox(height: 8),
          FieldName(name: StringRes.email.tr),
          const SizedBox(height: 10),
          OutlineTextField(
            controller: controller.email.controller,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            hint: StringRes.emailHint.tr,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 8),
          Obx(
            () => Visibility(
              visible: controller.isValidEmail.value ||
                  controller.isDuplicatedEmail.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ErrorText(
                  text: controller.isDuplicatedEmail.value
                      ? StringRes.emailDuplicated.tr
                      : StringRes.emailError.tr,
                ),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 30);
}

/// 휴대폰 번호 필드.
class PhoneNumberField extends GetView<SignUpController> {
  const PhoneNumberField({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          /// 휴대폰 번호.
          const SizedBox(height: 8),
          FieldName(name: StringRes.phoneNumber.tr),
          const SizedBox(height: 10),
          OutlineTextField(
            controller: controller.phoneNumber.controller,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            hint: StringRes.phoneHint.tr,
            keyboardType: TextInputType.phone,
            maxLength: 11,
            readOnly: false,
          ),
          const SizedBox(height: 8),
          Obx(
            () => Visibility(
              visible: controller.isValidPhoneNumber.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ErrorText(
                  text: StringRes.phoneNumberError.tr,
                ),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 30);
}

/// 생년월일 필드.
class BirthField extends GetView<SignUpController> {
  const BirthField({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 8),
          FieldName(name: StringRes.birth.tr),
          const SizedBox(height: 10),
          OutlineTextField(
            controller: controller.birth.controller,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            hint: StringRes.birthHint.tr,
            keyboardType: TextInputType.number,
            maxLength: 8,
            readOnly: false,
          ),
          const SizedBox(height: 8),
          Obx(
            () => Visibility(
              visible: controller.isValidBirth.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ErrorText(
                  text: StringRes.birthError.tr,
                ),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 30);
}

/// 성별 필드.
class GenderField extends GetView<SignUpController> {
  const GenderField({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 8),
          FieldName(name: StringRes.gender.tr),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => BaseButton(
                    height: 56,
                    isSelected: controller.gender.value == GenderType.male,
                    text: StringRes.male.tr,
                    onPressed: () {
                      controller.onPressedGenderButton(GenderType.male);
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Obx(
                  () => BaseButton(
                    height: 56,
                    isSelected: controller.gender.value == GenderType.female,
                    text: StringRes.female.tr,
                    onPressed: () {
                      controller.onPressedGenderButton(GenderType.female);
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ).paddingSymmetric(horizontal: 30);
}

/// 비밀번호 필드.
class PasswordField extends GetView<SignUpController> {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          /// 비밀번호.
          const SizedBox(height: 8),
          FieldName(name: StringRes.password.tr),
          const SizedBox(height: 10),
          OutlineTextField(
            controller: controller.password.controller,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            hint: StringRes.passwordHint.tr,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          ),
          const SizedBox(height: 8),
          OutlineTextField(
            controller: controller.passwordConfirm.controller,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            hint: StringRes.passwordConfirm.tr,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          ),
          const SizedBox(height: 8),
          Obx(
            () => Visibility(
              visible: controller.password.value.length < 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ErrorText(text: StringRes.passwordError.tr),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: controller.password.value.length >= 8 &&
                  controller.isValidPassword.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ErrorText(text: StringRes.passwordNotMatched.tr),
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 30);
}
