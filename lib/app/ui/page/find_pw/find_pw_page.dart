import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/find_pw/find_pw_controller.dart';

import '../../widgets/widgets.dart';

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
