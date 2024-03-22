import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';

class LabelButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;

  const LabelButton({
    super.key,
    required this.text,
    this.textStyle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(ColorRes.clickOverlayColor),
          minimumSize: MaterialStateProperty.all(Size.zero),
          padding: MaterialStateProperty.all(const EdgeInsets.all(4)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Fit 하게 만들어 줌
        ),
        child: Text(
          text,
          style: textStyle,
        ),
      );
}
