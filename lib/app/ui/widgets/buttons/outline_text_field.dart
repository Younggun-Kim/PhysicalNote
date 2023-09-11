import 'package:flutter/material.dart';

import '../../../resources/resources.dart';

class OutlineTextField extends StatelessWidget {
  /// 컨트롤러.
  final TextEditingController controller;

  /// 힌트.
  final String hint;

  /// 키보드 입력 타입.
  final TextInputType keyboardType;

  /// 암호화 여부.
  final bool obscureText;

  /// Inner Content Padding.
  /// Default - EdgeInsets.all(16)
  final EdgeInsets contentPadding;

  const OutlineTextField({
    key,
    required this.controller,
    this.hint = "",
    this.keyboardType = TextInputType.emailAddress,
    this.obscureText = false,
    this.contentPadding = const EdgeInsets.all(16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius =
        BorderRadius.circular(MediaQuery.of(context).size.height * 0.5);

    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: const BorderSide(
        width: 1,
        style: BorderStyle.solid,
        color: ColorRes.borderWhite,
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          focusedBorder: border,
          border: border,
          isDense: true,
          contentPadding: contentPadding,
        ),
      ),
    );
  }
}
