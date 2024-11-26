import 'package:get/get.dart';
import 'package:physical_note/app/data/common/common_api.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/ui/page/find_id/find_id.dart';

class FindIdBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FindIdController());
    Get.lazyPut(() => CommonAPI());
    Get.lazyPut(() => LoginAPI());
  }
}