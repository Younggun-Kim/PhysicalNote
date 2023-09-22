import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/change_password/change_password.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: FlexibleScrollView(
          child: Column(
            children: [
              _Header(),
              const SizedBox(height: 20),
              FieldName(name: StringRes.password.tr)
                  .paddingSymmetric(horizontal: 30),
              const SizedBox(height: 10),
              OutlineTextField(
                controller: controller.password.controller,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                hint: StringRes.passwordHint.tr,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ).paddingSymmetric(horizontal: 30),
              const SizedBox(height: 8),
              OutlineTextField(
                controller: controller.passwordConfirm.controller,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                hint: StringRes.passwordConfirm.tr,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ).paddingSymmetric(horizontal: 30),
              const SizedBox(height: 8),
              Obx(() => Visibility(
                  visible: controller.errorMessage.value.isNotEmpty,
                  child: _ErrorText(text: controller.errorMessage.value)
                      .paddingSymmetric(horizontal: 30))),
              const Spacer(),
              Obx(
                () => RoundButton(
                  width: double.infinity,
                  text: StringRes.next.tr,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  isEnabled: controller.errorMessage.value.isEmpty,
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

/// 헤더.
class _Header extends GetView<ChangePasswordController> {
  @override
  Widget build(BuildContext context) => Header(
        title: StringRes.changePassword.tr,
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

/// 에러 필드.
class _ErrorText extends StatelessWidget {
  final String text;

  const _ErrorText({required this.text});

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
