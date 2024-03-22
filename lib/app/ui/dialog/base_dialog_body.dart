import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';

class BaseDialogBody extends StatelessWidget {
  final String text;

  final Color backgroundColor;

  final String yesText;

  final Function() onPressedYes;

  final String noText;

  final Function() onPressedNo;

  final Function() close;

  const BaseDialogBody({
    super.key,
    required this.text,
    this.backgroundColor = Colors.transparent,
    required this.yesText,
    required this.onPressedYes,
    required this.noText,
    required this.onPressedNo,
    required this.close,
  });

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              close();
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: backgroundColor,
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
                        close();
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
                            onPressed: () => onPressedYes(),
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
                            onPressed: () => onPressedNo(),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      );
}
