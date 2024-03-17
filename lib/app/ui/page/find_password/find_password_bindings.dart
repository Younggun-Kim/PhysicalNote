import 'package:get/get.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/ui/page/find_password/find_password.dart';

class FindPasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FindPasswordController());
    Get.lazyPut(() => LoginAPI());
  }

}