import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/intensity_detail/intensity_detail_controller.dart';

class IntensityDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IntensityDetailController());
  }
}
