import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/find_password/find_password.dart';

class FindPasswordBindings extends Bindings {
  @override
  void dependencies() {
    return Get.lazyPut(() => FindPasswordController());
  }
}
