import 'package:get/get.dart';

import 'wellness_detail_controller.dart';

class WellnessDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WellnessDetailController());
  }
}