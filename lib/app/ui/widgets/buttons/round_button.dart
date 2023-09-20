import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';

class RoundButton extends StatelessWidget {
  // Container Attribute.
  final double? width;
  final double height;
  final double radius;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  // Button Attribute.
  final bool isEnabled;

  // Text Style.
  final String text;
  final TextStyle? textStyle;
  final Color? backgroundColor;

  final VoidCallback? onPressed;

  const RoundButton({
    Key? key,
    this.width,
    this.height = 56,
    this.radius = 28,
    this.margin,
    this.padding,
    required this.text,
    this.textStyle,
    this.backgroundColor = ColorRes.primary,
    this.isEnabled = true,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
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
              backgroundColor:
                  MaterialStateProperty.all(buttonBackgroundColor(isEnabled)),
              overlayColor:
                  MaterialStateProperty.all(ColorRes.clickOverlayColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ))),
          child: Text(
            text,
            style: textStyle ?? const TextStyle(
                    color: ColorRes.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
          ),
        ),
      );

  /// 버튼 배경색.
  Color? buttonBackgroundColor(bool isEnabled) {
    return isEnabled ? backgroundColor : ColorRes.disable;
  }
}
