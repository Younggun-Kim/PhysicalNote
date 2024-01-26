import 'package:get/get.dart';

import 'find_id_complete_controller.dart';

class FindIdCompleteBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FindIdCompleteController());
  }
}