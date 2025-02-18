import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextH3 extends StatelessWidget {
  final String text;

  const TextH3(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.headlineSmall,
    );
  }
}
