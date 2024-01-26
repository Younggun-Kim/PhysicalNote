import 'package:get/get.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/user/user_api.dart';
import 'package:physical_note/app/ui/page/splash/splash_controller.dart';
import 'package:physical_note/app/utils/sns/login_process.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    // ignore: prefer_const_constructors
    Get.put(LoginAPI());
    Get.put(UserAPI());
    Get.put(LoginProcess(loginApi: Get.find(), userApi: Get.find()));
    Get.put(SplashController());
  }
}
