import 'package:flutter/cupertino.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';

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
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.fontSize,
    this.onPressed,
  });

  get hasText => text.isNotEmpty;

  @override
  Widget build(BuildContext context) => InkWellOver(
        borderRadius: BorderRadius.circular(radius),
        onTap: onPressed,
        child: Container(
          width: width,
          height: height,
          padding: padding,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ColorRes.white,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: ColorRes.disable),
          ),
          child: Text(
            hasText ? text : hint,
            style: TextStyle(
              color: hasText ? ColorRes.fontBlack : ColorRes.fontDisable,
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
}
