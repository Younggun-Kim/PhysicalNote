import 'package:get/get.dart';
import 'package:physical_note/app/data/home/home_api.dart';
import 'package:physical_note/app/ui/page/home2/home.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());


    /// API
    Get.lazyPut(() => HomeAPI());
  }
}
