import 'package:get/get.dart';
import 'package:physical_note/app/data/common/common_api.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/ui/page/term/term_controller.dart';

class TermBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermController());
    Get.lazyPut(() => CommonAPI());
    Get.lazyPut(() => LoginAPI());
    Get.lazyPut(() => LoginAPI());
  }
}
