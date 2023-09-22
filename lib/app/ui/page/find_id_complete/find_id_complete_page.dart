import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/find_id_complete/find_id_complete.dart';
import 'package:physical_note/app/ui/widgets/buttons/round_button.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';


class FindIdCompletePage extends GetView<FindIdCompleteController> {
  const FindIdCompletePage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: Container(
          height: double.infinity,
          alignment: Alignment.center,
          child: Column(
            children: [
              _Header(),
              const Spacer(),
              SvgPicture.asset(Assets.check),
              const SizedBox(height: 14),
              Obx(
                () => EasyRichText(
                  StringRes.findIdResult.trParams({
                    'name': controller.name.value,
                    'email': controller.email.value,
                  }),
                  textAlign: TextAlign.center,
                  defaultStyle: const TextStyle(
                    color: ColorRes.fontBlack,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                  patternList: [
                    EasyRichTextPattern(
                      targetString: controller.email.value,
                      style: const TextStyle(
                        color: ColorRes.primary,
                      ),
                    ),
                  ],
                ),
              ),
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
        onPressed: controller.close,
      );
}
