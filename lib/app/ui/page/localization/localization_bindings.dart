import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/localization/localization_controller.dart';

class LocalizationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocalizationController());
  }
}