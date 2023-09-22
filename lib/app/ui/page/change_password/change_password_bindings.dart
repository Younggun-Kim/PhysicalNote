import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/change_password/change_password.dart';

class ChangePasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController());
  }
}