import 'package:get/get.dart';

import 'information_registration_guide_controller.dart';

class InformationRegistrationGuideBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InformationRegistrationGuideController());
  }
}