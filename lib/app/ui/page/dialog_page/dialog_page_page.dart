import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/dialog_page/dialog_page.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

/// 다이얼로그가 Stack에서 에러 발생시 사용
class DialogPagePage extends GetView<DialogPageController> {
  const DialogPagePage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        isFullPage: true,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                controller.close();
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                // color: Colors.transparent,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
              ),
            ),
            Center(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: ColorRes.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWellOver(
                        child: SvgPicture.asset(Assets.xClose),
                        onTap: () {
                          controller.close();
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      controller.text,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 20,
                        color: ColorRes.fontBlack,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 60),
                    Row(
                      children: [
                        if (controller.yesText.isNotEmpty)
                          Expanded(
                            child: BaseButton(
                              height: 56,
                              isSelected: true,
                              selectedTextStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ColorRes.white,
                              ),
                              text: controller.yesText,
                              onPressed: () {
                                controller.onPressedYes();
                              },
                            ),
                          ),
                        if (controller.noText.isNotEmpty)
                          Expanded(
                            child: BaseButton(
                              height: 56,
                              text: controller.noText,
                              defaultTextStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ColorRes.fontBlack,
                              ),
                              onPressed: () => controller.onPressedNo(),
                            ),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
