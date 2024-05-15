import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:physical_note/app/resources/colors/color_res.dart';

class BottomBorderTextField extends StatelessWidget {
  // Container
  final double? height;

  // TextField
  final TextEditingController controller;

  final int? maxLength;

  final TextInputType keyboardType;

  final bool obscureText; // 암호화 여부.

  final TextStyle? textStyle;

  final bool readOnly;

  // - Decoration
  final String hint;

  final EdgeInsets contentPadding;

  final List<TextInputFormatter>? inputFormatters;

  final ValueChanged<String>? onChanged;

  BottomBorderTextField({
    super.key,
    this.height = 56,
    required this.controller,
    this.maxLength,
    required this.keyboardType,
    required this.obscureText,
    this.textStyle,
    this.readOnly = false,
    required this.hint,
    required this.contentPadding,
    this.inputFormatters,
    this.onChanged,
  });

  // 기본 입력 포맷
  final defaultDigitInputFormatters = <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly
  ];

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        height: height,
        alignment: Alignment.center,
        padding: contentPadding,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorRes.disable, // 테두리 색상 설정
              width: 1.0, // 테두리 두께 설정
            ),
          ),
        ),
        child: TextField(
          controller: controller,
          maxLength: maxLength,
          keyboardType: keyboardType,
          readOnly: readOnly,
          style: textStyle,
          inputFormatters: inputFormatters ?? defaultDigitInputFormatters,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: textStyle?.fontSize,
              color: ColorRes.fontDisable,
              fontWeight: textStyle?.fontWeight,
            ),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
            counterText: '',
          ),
          onChanged: onChanged,
        ),
      );
}
