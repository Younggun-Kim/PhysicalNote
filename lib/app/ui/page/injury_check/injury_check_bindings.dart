import 'package:get/get.dart';
import 'package:physical_note/app/data/injury/injury_api.dart';

import 'injury_check_controller.dart';

class InjuryCheckBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InjuryAPI());
    Get.lazyPut(() => InjuryCheckController());
  }
}