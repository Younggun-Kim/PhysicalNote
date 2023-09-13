import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/sign_up/sign_up_controller.dart';
import 'package:physical_note/app/utils/base/widget/page_root.dart';


/// 회원가입 화면.
class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      child: Text("회원가입"),
    );
  }
}
