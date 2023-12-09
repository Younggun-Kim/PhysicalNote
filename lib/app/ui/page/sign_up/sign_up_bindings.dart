import 'package:get/get.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/ui/page/sign_up/sign_up.dart';

class SignUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginAPI());
    Get.lazyPut(() => SignUpController());
  }
}
