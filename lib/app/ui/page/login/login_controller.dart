import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/utils/base/getx/base_controller.dart';
import 'package:physical_note/app/utils/base/getx/getx_ext.dart';

class LoginController extends BaseController {
  /// 이메일 컨트롤러.
  final email = "".obsWithController;

  /// 이메일 유효성 검사.
  late final isValidEmail = false.obs
    ..bindStream(
      email.stream.map((event) => !event.isEmail),
    );

  /// 패스워드 컨트롤러.
  final passwordController = TextEditingController();

  @override
  void dispose() {
    email.close();
    super.dispose();
  }
}
