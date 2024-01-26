import 'package:get/get.dart';

import 'pass_controller.dart';

class PassBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PassController());
  }
}