import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/injury_check/injury_check.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';
import 'package:physical_note/app/utils/extensions/date_extensions.dart';

class InjuryCheckPage extends GetView<InjuryCheckController> {
  const InjuryCheckPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: FlexibleScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    controller.args.date.toFormattedString("yyyy년 MM월 dd일"),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorRes.fontBlack,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SvgPicture.asset(Assets.codeBrowser),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                StringRes.injuryLocationSelection.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ColorRes.fontBlack,
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => Row(
                  children: [
                    BaseButton(
                      isSelected:
                          controller.injuryType.value == InjuryType.nonContact,
                      text: InjuryType.nonContact.toString(),
                      onPressed: () {
                        controller.onPressedInjuryType(InjuryType.nonContact);
                      },
                    ),
                    const SizedBox(width: 10),
                    BaseButton(
                      isSelected:
                          controller.injuryType.value == InjuryType.contact,
                      text: InjuryType.contact.toString(),
                      onPressed: () {
                        controller.onPressedInjuryType(InjuryType.contact);
                      },
                    ),
                    const SizedBox(width: 10),
                    BaseButton(
                      isSelected:
                          controller.injuryType.value == InjuryType.disease,
                      text: InjuryType.disease.toString(),
                      onPressed: () {
                        controller.onPressedInjuryType(InjuryType.disease);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

/// 헤더.
class _Header extends GetView<InjuryCheckController> {
  @override
  Widget build(BuildContext context) => Header(
        title: StringRes.injuryCheck.tr,
        showBack: true,
        onPressed: controller.close,
        padding: EdgeInsets.zero,
      );
}
