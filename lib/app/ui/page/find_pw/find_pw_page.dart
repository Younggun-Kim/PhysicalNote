import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/find_pw/find_pw_controller.dart';
import 'package:physical_note/app/utils/base/widget/page_root.dart';

class FindPwPage extends GetView<FindPwController> {
  const FindPwPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      child: Text("비밀번호 찾기"),
    );
  }
}
