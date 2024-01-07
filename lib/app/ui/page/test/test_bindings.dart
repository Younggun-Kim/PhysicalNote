import 'package:get/get.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/naver/naver_api.dart';
import 'package:physical_note/app/data/user/user_api.dart';
import 'package:physical_note/app/ui/page/test/test.dart';

import '../../../utils/sns/login_process.dart';

class TestBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NaverAPI());
    Get.lazyPut(() => TestController());
    Get.lazyPut(() => LoginAPI());
    Get.lazyPut(() => UserAPI());
    Get.lazyPut(() => LoginProcess(loginApi: Get.find(), userApi: Get.find()));
  }
}