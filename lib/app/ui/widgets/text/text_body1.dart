import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/utils/theme/text_theme.dart';

class TextBody1 extends StatelessWidget {
  final String text;

  final bool isBold;

  const TextBody1(
    this.text, {
    super.key,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.getBodyLarge(isBold),
    );
  }
}
