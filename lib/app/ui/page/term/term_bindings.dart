import 'package:get/get.dart';
import 'package:physical_note/app/data/common/common_api.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/user/user_api.dart';
import 'package:physical_note/app/ui/page/term/term_controller.dart';
import 'package:physical_note/app/utils/sns/login_process.dart';

class TermBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermController());
    Get.lazyPut(() => CommonAPI());
    Get.lazyPut(() => LoginAPI());
    Get.lazyPut(() => UserAPI());
    Get.lazyPut(() => LoginProcess(loginApi: Get.find(), userApi: Get.find()));
  }
}
