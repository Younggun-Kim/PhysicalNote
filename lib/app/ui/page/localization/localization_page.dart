import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/localization/localization_controller.dart';
import 'package:physical_note/app/utils/base/widget/page_root.dart';

class LocalizationPage extends GetView<LocalizationController> {
  const LocalizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      child: Text("한국어"),
    );
  }
}
