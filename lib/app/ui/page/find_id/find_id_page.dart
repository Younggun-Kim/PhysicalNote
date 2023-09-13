import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/find_id/find_id_controller.dart';
import 'package:physical_note/app/utils/base/widget/page_root.dart';

/// 아이디 찾기 화면.
class FindIdPage extends GetView<FindIdController> {
  const FindIdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      child: Text("아이디 찾기"),
    );
  }
}
