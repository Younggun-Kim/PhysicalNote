import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 숫자전용 TextEditing Controller
class GetxTextEditingNumberController extends RxString {
  late final FocusNode focusNode;
  late final TextEditingController controller;

  GetxTextEditingNumberController(String value) : super(value) {
    focusNode = FocusNode();
    controller = TextEditingController(text: value)
      ..addListener(() {
        final oldValue = this.value;
        final newValue = controller.text;

        /// 실수형이 아니면 이전 값을 유지.
        if (double.tryParse(newValue) == null) {
          this.value = oldValue;
        } else if (newValue != oldValue) {
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

extension GetxTextEditingNumberControllerExt on String {
  GetxTextEditingNumberController get obsWithNumberController =>
      GetxTextEditingNumberController(this);
}
