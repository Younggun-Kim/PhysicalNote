import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/find_id/find_id_controller.dart';

class FindIdBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FindIdController());
  }
}