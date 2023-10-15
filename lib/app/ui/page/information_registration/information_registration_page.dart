import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/information_registration/information_registration.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

/// 정보등록 뷰.
class InformationRegistrationPage
    extends GetView<InformationRegistrationController> {
  const InformationRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(),
              _FieldName(text: StringRes.category.tr),
              const SizedBox(height: 10),
              _ListSearchButton(
                text: "",
              ),
              const SizedBox(height: 36),
              _FieldName(text: StringRes.sports.tr),
              const SizedBox(height: 10),
              _ListSearchButton(
                text: "",
              ),
              const SizedBox(height: 52),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => RoundButton(
                        text: StringRes.amateur.tr,
                        isSelected: controller.isAmateur.value,
                        backgroundColor: ColorRes.white,
                        selectedColor: ColorRes.primary,
                        textStyle: const TextStyle(
                          color: ColorRes.fontBlack,
                          fontSize: 16,
                        ),
                        selectedTextStyle: const TextStyle(
                          color: ColorRes.fontBlack,
                          fontSize: 16,
                        ),
                        border: Border.all(color: ColorRes.borderDeselect),
                        onPressed: controller.onPressedAmateur,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Obx(
                      () => RoundButton(
                        text: StringRes.elite.tr,
                        isEnabled: true,
                        isSelected: controller.isElite.value,
                        backgroundColor: ColorRes.white,
                        selectedColor: ColorRes.primary,
                        textStyle: const TextStyle(
                          color: ColorRes.fontBlack,
                          fontSize: 16,
                        ),
                        selectedTextStyle: const TextStyle(
                          color: ColorRes.fontBlack,
                          fontSize: 16,
                        ),
                        border: Border.all(color: ColorRes.borderDeselect),
                        onPressed: controller.onPressedElite,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              RoundButton(
                width: double.infinity,
                text: StringRes.next.tr,
                isEnabled: false,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      );
}

/// 필드명.
class _FieldName extends StatelessWidget {
  final String text;

  const _FieldName({required this.text});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: Text(
          text,
          style: const TextStyle(
            color: ColorRes.fontBlack,
            fontSize: 16,
          ),
        ),
      );
}

/// 눌러서 선택.
class _ListSearchButton extends GetView<InformationRegistrationController> {
  final String text;

  const _ListSearchButton({required this.text});

  bool get hasText => text.isNotEmpty;

  @override
  Widget build(BuildContext context) => InkWellOver(
        borderRadius: BorderRadius.circular(28),
        onTap: () => {
          logger.d("cli"),
        },
        child: Container(
          height: 56,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          decoration: BoxDecoration(
            color: ColorRes.white,
            border: Border.all(color: ColorRes.borderDeselect),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  hasText ? text : StringRes.clickToSelect.tr,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: hasText ? ColorRes.fontBlack : ColorRes.fontDisable,
                  ),
                ),
              ),
              SvgPicture.asset(Assets.searchRefraction),
            ],
          ),
        ),
      );
}
