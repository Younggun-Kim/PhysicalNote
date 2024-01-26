import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetxTextEditingController extends RxString {
  late final FocusNode focusNode;
  late final TextEditingController controller;

  GetxTextEditingController(String value) : super(value) {
    focusNode = FocusNode();
    controller = TextEditingController(text: value)
      ..addListener(() {
        final oldValue = this.value;
        final newValue = controller.text;

        if (newValue != oldValue) {
          this.value = newValue;
        }
      });
  }

  @override
  set value(String val) {
    final currentVal = controller.text;
    if (currentVal != val) {
      controller.value = TextEditingValue(
        text: val,
        selection: TextSelection.fromPosition(
          TextPosition(offset: val.length),
        ),
      );
    }
    super.value = val;
  }

  @override
  void close() {
    focusNode.dispose();
    controller.dispose();
    super.close();
  }
}

extension GetxTextEditingControllerExt on String {
  GetxTextEditingController get obsWithController =>
      GetxTextEditingController(this);
}
