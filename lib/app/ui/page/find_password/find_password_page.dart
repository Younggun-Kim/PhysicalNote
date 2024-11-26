import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/find_password/find_password.dart';
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
            _PhoneField(),
            _AuthCodeField(),
            const Spacer(),
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: RoundButton(
                  text: StringRes.next.tr,
                  width: double.infinity,
                  height: 56,
                  isEnabled: controller.isAuth.value,
                  onPressed: controller.onPressedNextButton,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ));
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

/// 휴대폰 번호 필드.
class _PhoneField extends GetView<FindPasswordController> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 8),
          FieldName(name: StringRes.phoneNumber.tr),
          const SizedBox(height: 10),
          OutlineTextField(
            controller: controller.phone.controller,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            hint: StringRes.phoneHint.tr,
            keyboardType: TextInputType.phone,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            rightWidget: Obx(
              () => _authButton(
                isEnabled: controller.isValidPhoneNumber.value,
                isSelected: controller.isRequestAuth.value,
                onPressed: controller.onPressedAuthButton,
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 30);

  /// 인증버튼
  Widget _authButton(
      {required bool isEnabled,
      required bool isSelected,
      required VoidCallback onPressed}) {
    return BaseButton(
      text: isSelected ? StringRes.reVerify.tr : StringRes.verify.tr,
      height: 36,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      isEnabled: isEnabled,
      isSelected: isSelected,
      defaultTextStyle: const TextStyle(
        fontSize: 14,
        color: ColorRes.fontBlack,
      ),
      defaultBackgroundColor: ColorRes.primary,
      selectedBackgroundColor: ColorRes.primary,
      onPressed: onPressed,
    );
  }
}

/// 인증번호 번호 필드.
class _AuthCodeField extends GetView<FindPasswordController> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 10),
          OutlineTextField(
            controller: controller.authCode.controller,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            maxLength: 6,
            hint: StringRes.authCodeHint.tr,
            keyboardType: TextInputType.number,
            onChanged: (code) {
              controller.onChangedAuthCode();
            },
          ),
        ],
      ).paddingSymmetric(horizontal: 30);
}
