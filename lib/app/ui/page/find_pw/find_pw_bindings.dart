import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/find_pw/find_pw_controller.dart';

class FindPwBindings extends Bindings {
  @override
  void dependencies() {
    return Get.lazyPut(() => FindPwController());
  }
}