import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/term/term_controller.dart';

import '../../widgets/widgets.dart';

class TermPage extends GetView<TermController> {
  const TermPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      child: Column(
        children: [
          _Header(),
        ],
      ),
    );
  }
}

class _Header extends GetView<TermController> {
  @override
  Widget build(BuildContext context) => Header(
        title: "",
        showBack: true,
        onPressed: controller.onPressedNavigationBackButton,
      );
}
