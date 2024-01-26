import 'package:get/get.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/user/user_api.dart';
import 'package:physical_note/app/ui/page/sign_up/sign_up.dart';
import 'package:physical_note/app/utils/sns/login_process.dart';

class SignUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginAPI());
    Get.lazyPut(() => UserAPI());
    Get.lazyPut(() => LoginProcess(loginApi: Get.find(), userApi: Get.find()));
    Get.lazyPut(() => SignUpController());
  }
}
