import 'package:flutter/material.dart';

import '../../resources/resources.dart';

class OutlineTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const OutlineTextField({
    key,
    required this.controller,
    this.hint = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius =
        BorderRadius.circular(MediaQuery.of(context).size.height * 0.5);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: const BorderSide(
              width: 1,
              style: BorderStyle.solid,
              color: ColorRes.borderWhite,
            ),
          ),
        ),
      ),
    );
  }
}
