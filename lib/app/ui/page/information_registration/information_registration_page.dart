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
                    child: RoundButton(
                      text: StringRes.amateur.tr,
                      isEnabled: false,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: RoundButton(
                      text: StringRes.elite.tr,
                      isEnabled: false,
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
    onTap: () => {logger.d("cli")},
    child: Container(
      height: 56,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        border: Border.all(color: ColorRes.borderDeselect),
        borderRadius: BorderRadius.circular(28),
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