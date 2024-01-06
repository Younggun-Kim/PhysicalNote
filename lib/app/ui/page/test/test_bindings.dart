import 'package:get/get.dart';
import 'package:physical_note/app/data/naver/naver_api.dart';
import 'package:physical_note/app/ui/page/test/test.dart';

class TestBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NaverAPI());
    Get.lazyPut(() => TestController());
  }
}