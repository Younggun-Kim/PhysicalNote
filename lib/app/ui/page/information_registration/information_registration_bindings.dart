import 'package:get/get.dart';
import 'package:physical_note/app/data/user/user_api.dart';
import 'package:physical_note/app/ui/page/information_registration/information_registration.dart';

class InformationRegistrationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserAPI());
    Get.lazyPut(() => InformationRegistrationController());
  }
}
