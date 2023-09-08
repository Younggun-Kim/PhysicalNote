import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/splash/splash_controller.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    // ignore: prefer_const_constructors
    Get.put(SplashController());
  }
}
