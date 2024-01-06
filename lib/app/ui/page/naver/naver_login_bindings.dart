import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/naver/naver_login.dart';

class NaverLoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NaverLoginController());
  }
}
