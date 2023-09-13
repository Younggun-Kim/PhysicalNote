import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/term/term_controller.dart';
import 'package:physical_note/app/utils/base/widget/page_root.dart';

class TermPage extends GetView<TermController> {
  const TermPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      child: Text("서비스 이용약관 동의"),
    );
  }
}
