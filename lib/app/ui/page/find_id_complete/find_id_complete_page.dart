import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/find_id_complete/find_id_complete.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

class FindIdCompletePage extends GetView<FindIdCompleteController> {
  const FindIdCompletePage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              _Header(),
              const SizedBox(height: 40),
              Obx(
                () => _UserInfo(
                  name: controller.name.value,
                  phone: controller.phone.value,
                ),
              ),
              const SizedBox(height: 60),
              const Spacer(),
              LabelButton(
                text: StringRes.findPw.tr,
                textStyle: const TextStyle(
                  color: ColorRes.fontDisable,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                onPressed: controller.onPressedFindPassword,
              ),
              const SizedBox(height: 12),
              RoundButton(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                text: StringRes.login.tr,
                onPressed: controller.onPressedLogin,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      );
}

/// 헤더.
class _Header extends GetView<FindIdCompleteController> {
  @override
  Widget build(BuildContext context) => Header(
        title: StringRes.findId.tr,
        showBack: true,
        padding: EdgeInsets.zero,
        onPressed: controller.close,
      );
}

/// 유저 정보.
class _UserInfo extends StatelessWidget {
  final String name;
  final String phone;

  const _UserInfo({
    required this.name,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringRes.name.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorRes.fontBlack,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    StringRes.phoneNumber.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorRes.fontBlack,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 26),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorRes.fontBlack,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    phone,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorRes.fontBlack,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            StringRes.resultOfSignedInId.tr,
            style: const TextStyle(
              fontSize: 14,
              color: ColorRes.fontBlack,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
}
