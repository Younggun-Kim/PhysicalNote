import 'package:get/get.dart';

import 'injury_check_controller.dart';

class InjuryCheckBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InjuryCheckController());
  }
}