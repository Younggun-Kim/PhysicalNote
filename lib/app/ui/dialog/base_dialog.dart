import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/buttons/base_button.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';

class BaseDialog extends StatelessWidget {
  final String text;

  final String yesText;

  final VoidCallback onPressedYes;

  const BaseDialog({
    super.key,
    required this.text,
    required this.yesText,
    required this.onPressedYes,
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
                padding: const EdgeInsets.symmetric(vertical: 16),
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
                    Expanded(
                      child: Text(
                        text,
                        style: const TextStyle(
                          fontSize: 20,
                          color: ColorRes.fontBlack,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    BaseButton(text: yesText, onPressed: onPressedYes),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
