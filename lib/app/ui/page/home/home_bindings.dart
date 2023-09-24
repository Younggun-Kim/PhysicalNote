import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/home/home.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    return Get.lazyPut(() => HomeController());
  }
}