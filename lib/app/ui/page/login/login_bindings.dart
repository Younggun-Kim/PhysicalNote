import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/app_constant.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/naver/naver_api.dart';
import 'package:physical_note/app/data/user/user_api.dart';
import 'package:physical_note/app/ui/page/login/login_controller.dart';
import 'package:physical_note/app/utils/sns/apple_login.dart';
import 'package:physical_note/app/utils/sns/kakao_login.dart';
import 'package:physical_note/app/utils/sns/login_process.dart';
import 'package:physical_note/app/utils/sns/naver_login.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginAPI());
    Get.lazyPut(() => UserAPI());
    Get.lazyPut(() => KakaoLogin().init(AppConstant.kakaoNativeKey));
    Get.lazyPut(() => NaverLogin());
    Get.lazyPut(() => NaverAPI());
    Get.lazyPut(() => AppleLogin());
    Get.lazyPut(() => LoginProcess(loginApi: Get.find(), userApi: Get.find()));
    Get.lazyPut(() => LoginController(api: Get.find()));
  }
}
