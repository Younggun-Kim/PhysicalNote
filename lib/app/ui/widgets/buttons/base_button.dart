import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/colors/color_res.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';

class BaseButton extends StatelessWidget {
  /// Common.
  final bool isSelected;

  /// InkWellOver Widget.
  final Function() onPressed;

  /// Container Widget.
  final EdgeInsets padding;

  final Color defaultBackgroundColor;

  final Color selectedBackgroundColor;

  /// Text Widget.
  final String text;

  final TextStyle defaultTextStyle;

  final TextStyle selectedTextStyle;

  const BaseButton({
    super.key,
    required this.isSelected,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.defaultBackgroundColor = ColorRes.white,
    this.selectedBackgroundColor = ColorRes.primary,
    required this.text,
    this.defaultTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ColorRes.fontBlack,
    ),
    this.selectedTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ColorRes.fontBlack,
    ),
    required this.onPressed,
  });

  /// 백그라운드 색상.
  Color get backgroundColor =>
      isSelected ? selectedBackgroundColor : defaultBackgroundColor;

  /// 텍스트 스타일.
  TextStyle get textStyle => isSelected ? defaultTextStyle : selectedTextStyle;

  @override
  Widget build(BuildContext context) => InkWellOver(
        onTap: onPressed,
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.height * 0.5),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            border: Border.all(color: ColorRes.borderWhite),
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.height * 0.5),
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
                blurStyle: BlurStyle.normal,
              ),
            ],
          ),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      );
}
