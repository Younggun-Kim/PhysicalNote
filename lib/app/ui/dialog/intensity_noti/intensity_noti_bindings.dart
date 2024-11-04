import 'package:get/get.dart';
import 'package:physical_note/app/ui/dialog/intensity_noti/intensity_noti.dart';

class IntensityNotiBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(IntensityNotiController());
  }
}
