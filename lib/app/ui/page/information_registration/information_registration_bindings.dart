import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/information_registration/information_registration.dart';

class InformationRegistrationBindings extends Bindings {
  @override
  void dependencies() {
    return Get.lazyPut(() => InformationRegistrationController());
  }
}
