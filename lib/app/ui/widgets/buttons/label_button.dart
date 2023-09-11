import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';

class BaseTextButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;

  const BaseTextButton({
    Key? key,
    required this.text,
    this.textStyle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(ColorRes.clickOverlayColor),
          minimumSize: MaterialStateProperty.all(Size.zero),
          padding: MaterialStateProperty.all(const EdgeInsets.all(4)),
        ),
        child: Text(
          text,
          style: textStyle,
        ),
      );
}
