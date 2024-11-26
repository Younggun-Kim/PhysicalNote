import 'package:get/get.dart';
import 'package:physical_note/app/data/common/common_api.dart';
import 'package:physical_note/app/ui/page/find_password/find_password.dart';

class FindPasswordBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FindPasswordController());
    Get.lazyPut(() => FindPasswordController());
    Get.lazyPut(() => CommonAPI());
  }
}
