import 'package:get/get.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/ui/page/login/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginAPI());
    Get.lazyPut(() => LoginController(api: Get.find()));
  }
}
