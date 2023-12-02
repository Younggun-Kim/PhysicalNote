import 'package:flutter/cupertino.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/buttons/round_button.dart';

/// Outline 형태 Round 버튼
class OutlineRoundButton extends StatelessWidget {
  final double? width;

  final double height;

  final String hint;

  final String text;

  final double? fontSize;

  final double radius;

  final EdgeInsets? padding;

  final VoidCallback? onPressed;

  const OutlineRoundButton({
    super.key,
    this.width,
    this.height = 56,
    this.radius = 28,
    required this.hint,
    required this.text,
    this.padding,
    this.fontSize,
    this.onPressed,
  });

  get hasText => text.isNotEmpty;

  @override
  Widget build(BuildContext context) => RoundButton(
        width: width,
        height: height,
        radius: radius,
        padding: padding,
        backgroundColor: ColorRes.white,
        alignment: Alignment.centerLeft,
        border: Border.all(
          color: ColorRes.disable,
        ),
        text: hasText ? text : hint,
        textStyle: TextStyle(
          color: hasText ? ColorRes.fontBlack : ColorRes.fontDisable,
          fontSize: fontSize,
        ),
        onPressed: onPressed,
      );
}
