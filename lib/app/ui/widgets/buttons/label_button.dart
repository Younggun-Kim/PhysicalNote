import 'package:flutter/material.dart';
import 'package:physical_note/app/resources/resources.dart';

class LabelButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final EdgeInsets padding;
  final VoidCallback? onPressed;

  const LabelButton({
    super.key,
    required this.text,
    this.textStyle,
    this.padding = const EdgeInsets.all(4),
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(ColorRes.clickOverlayColor),
          minimumSize: WidgetStateProperty.all(Size.zero),
          padding: WidgetStateProperty.all(padding),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Fit 하게 만들어 줌
        ),
        child: Text(
          text,
          style: textStyle,
        ),
      );
}
