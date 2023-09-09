import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/login/login_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}