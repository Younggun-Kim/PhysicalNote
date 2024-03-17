import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/colors/color_res.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';

class BaseButton extends StatelessWidget {
  /// Common.
  final bool isSelected;

  final bool isEnabled;

  /// InkWellOver Widget.
  final Function() onPressed;

  /// Container Widget.
  final double? width;

  final double? height;

  final EdgeInsets padding;

  final Color defaultBackgroundColor;

  final Color disableBackgroundColor;

  final Color selectedBackgroundColor;

  /// Text Widget.
  final String text;

  final TextStyle defaultTextStyle;

  final TextStyle disableTextStyle;

  final TextStyle selectedTextStyle;

  const BaseButton({
    super.key,
    this.isSelected = false,
    this.isEnabled = true,
    this.width,
    this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.defaultBackgroundColor = ColorRes.white,
    this.disableBackgroundColor = ColorRes.disable,
    this.selectedBackgroundColor = ColorRes.primary,
    required this.text,
    this.defaultTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ColorRes.fontBlack,
    ),
    this.disableTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ColorRes.white,
    ),
    this.selectedTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ColorRes.fontBlack,
    ),
    required this.onPressed,
  });

  /// 백그라운드 색상.
  Color get backgroundColor => isEnabled
      ? isSelected
          ? selectedBackgroundColor
          : defaultBackgroundColor
      : ColorRes.disable;

  /// 텍스트 스타일.
  TextStyle get textStyle => isEnabled
      ? isSelected
          ? selectedTextStyle
          : defaultTextStyle
      : disableTextStyle;

  @override
  Widget build(BuildContext context) => InkWellOver(
        onTap: isEnabled ? onPressed : null,
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.height * 0.5),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          alignment: Alignment.center,
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
