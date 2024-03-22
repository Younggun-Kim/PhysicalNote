import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';

class RoundButton extends StatelessWidget {
  // Container Attribute.
  final double? width;
  final double height;
  final double radius;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Border? border;

  // Button Attribute.
  final Alignment alignment;
  final bool isEnabled;
  final bool isSelected;
  final Color? backgroundColor;
  final Color? selectedColor;
  final Color? disabledColor;

  // Text Style.
  final String text;
  final TextStyle? textStyle;
  final TextStyle? selectedTextStyle;
  final TextStyle? disabledTextStyle;

  final VoidCallback? onPressed;

  const RoundButton({
    super.key,
    this.width,
    this.height = 56,
    this.radius = 28,
    this.margin,
    this.padding,
    this.border,
    this.alignment = Alignment.center,
    this.isEnabled = true,
    this.isSelected = false,
    this.backgroundColor = ColorRes.primary,
    this.selectedColor,
    this.disabledColor = ColorRes.disable,
    required this.text,
    this.textStyle = const TextStyle(
      color: ColorRes.white,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    this.selectedTextStyle,
    this.disabledTextStyle = const TextStyle(
      color: ColorRes.white,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: buttonBackgroundColor,
          border: border,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonBackgroundColor),
            alignment: alignment,
            overlayColor: MaterialStateProperty.all(ColorRes.clickOverlayColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          ),
          child: Text(
            text,
            style: buttonTextStyle,
          ),
        ),
      );

  /// 버튼 배경색.
  Color? get buttonBackgroundColor => isEnabled
      ? isSelected
          ? selectedColor
          : backgroundColor
      : disabledColor;

  /// 텍스트 스타일.
  TextStyle? get buttonTextStyle => isEnabled
      ? isSelected
          ? selectedTextStyle
          : textStyle
      : disabledTextStyle;
}
