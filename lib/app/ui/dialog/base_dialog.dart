import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/dialog/base_dialog_body.dart';

class BaseDialog extends StatelessWidget {
  final String text;

  final String yesText;

  final Function() onPressedYes;

  final String noText;

  final Function() onPressedNo;

  const BaseDialog({
    super.key,
    required this.text,
    required this.yesText,
    required this.onPressedYes,
    required this.noText,
    required this.onPressedNo,
  });

  void close<T>({
    T? result,
  }) {
    Get.back(result: result, closeOverlays: false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: BaseDialogBody(
          text: text,
          yesText: yesText,
          onPressedYes: onPressedYes,
          noText: noText,
          onPressedNo: onPressedNo,
          close: close,
        ),
      );
}
