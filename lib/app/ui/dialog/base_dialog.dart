import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/buttons/base_button.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';

class BaseDialog extends StatelessWidget {
  final String text;

  final String yesText;

  final Future Function()? onPressedYes;

  final String noText;

  final Future Function()? onPressedNo;

  const BaseDialog({
    super.key,
    required this.text,
    required this.yesText,
    required this.onPressedYes,
    required this.noText,
    required this.onPressedNo,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
              ),
            ),
            Center(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                          Get.back();
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      text,
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
                        if (yesText.isNotEmpty)
                          Expanded(
                            child: BaseButton(
                              height: 56,
                              isSelected: true,
                              selectedTextStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ColorRes.white,
                              ),
                              text: yesText,
                              onPressed: () async {
                                if (onPressedYes != null) {
                                  await onPressedYes!();
                                }
                                Get.back();
                              },
                            ),
                          ),
                        if (noText.isNotEmpty)
                          Expanded(
                            child: BaseButton(
                              height: 56,
                              text: noText,
                              defaultTextStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: ColorRes.fontBlack,
                              ),
                              onPressed: () async {
                                if (onPressedNo != null) {
                                  await onPressedYes!();
                                }
                                Get.back();
                              },
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
