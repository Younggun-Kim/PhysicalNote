import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/utils/base/getx/base_controller.dart';
import 'package:physical_note/app/utils/base/getx/getx_text_editing_controller.dart';
import 'package:physical_note/app/utils/base/getx/rx_extensions.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

class LoginController extends BaseController {
  /// 이메일 컨트롤러.
  final email = "".obsWithController;

  /// 이메일 유효성 검사.
  late final isValidEmail = false.obs
    ..bindStream(
      email.behaviorStream.map((event) => !event.isEmail),
    );

  /// 패스워드 컨트롤러.
  final password = "".obsWithController;

  /// 비밀번호 유효성 검사.
  late final isValidPassword = false.obs
    ..bindStream(
      password.behaviorStream.map((event) => event.length > 8),
    );

  /// 간편 회원가입 클릭.
  void onPressedSimpleSignUp() {
    logger.i("간편 회원가입 클릭");
  }

  /// 로그인 버튼 클릭.
  void onPressedLogin() {
    logger.i("로그인 클릭");
  }

  @override
  void dispose() {
    email.close();
    super.dispose();
  }
}
