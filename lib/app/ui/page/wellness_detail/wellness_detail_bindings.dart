import 'package:get/get.dart';
import 'package:physical_note/app/data/wellness/wellness_api.dart';

import 'wellness_detail_controller.dart';

class WellnessDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WellnessDetailController());

    /// API
    Get.lazyPut(() => WellnessAPI());
  }
}