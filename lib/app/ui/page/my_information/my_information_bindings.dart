import 'package:get/get.dart';
import 'package:physical_note/app/data/user/user_api.dart';
import 'package:physical_note/app/ui/page/my_information/my_information.dart';

class MyInformationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserAPI());
    Get.lazyPut(() => MyInformationController());
  }
}
