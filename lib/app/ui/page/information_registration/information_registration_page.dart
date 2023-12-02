import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/information_registration/information_registration.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

/// 정보등록 뷰.
class InformationRegistrationPage
    extends GetView<InformationRegistrationController> {
  const InformationRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              _Header(),
              const Spacer(),
              _FieldName(text: StringRes.category.tr),
              const SizedBox(height: 10),
              Obx(
                () => _ListSearchButton(
                  text: controller.category.value?.name ?? "",
                  onTap: controller.onPressedCategory,
                ),
              ),
              const SizedBox(height: 36),
              _FieldName(text: StringRes.sports.tr),
              const SizedBox(height: 10),
              Obx(
                () => _ListSearchButton(
                  text: controller.sports.value?.name ?? "",
                  onTap: controller.onPressedSports,
                ),
              ),
              const SizedBox(height: 52),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => RoundButton(
                        text: StringRes.amateur.tr,
                        isSelected: controller.isElite.value == false,
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
                        isSelected: controller.isElite.value == true,
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
              Obx(
                () => RoundButton(
                  width: double.infinity,
                  text: StringRes.next.tr,
                  isEnabled: controller.isEnabledNext.value,
                  onPressed: controller.onPressedNext,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      );
}

/// 헤더.
class _Header extends GetView<InformationRegistrationController> {
  @override
  Widget build(BuildContext context) => Header(
        title: "",
        showBack: true,
        onPressed: controller.close,
        padding: const EdgeInsets.symmetric(horizontal: 4),
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

  final VoidCallback? onTap;

  const _ListSearchButton({
    required this.text,
    this.onTap,
  });

  bool get hasText => text.isNotEmpty;

  @override
  Widget build(BuildContext context) => InkWellOver(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
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
