import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/app_constant.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/ui/page/login/login_controller.dart';
import 'package:physical_note/app/utils/sns/kakao_login.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginAPI());
    Get.lazyPut(() => KakaoLogin().init(AppConstant.kakaoNativeKey));
    Get.lazyPut(() => LoginController(api: Get.find()));
  }
}
