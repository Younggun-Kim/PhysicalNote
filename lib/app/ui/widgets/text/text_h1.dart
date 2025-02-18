import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextH1 extends StatelessWidget {
  final String text;

  const TextH1(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.headlineLarge,
    );
  }
}
