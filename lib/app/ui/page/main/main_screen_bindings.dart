import 'package:get/get.dart';
import 'package:physical_note/app/data/home/home_api.dart';
import 'package:physical_note/app/data/wellness/wellness_api.dart';
import 'package:physical_note/app/ui/page/data/data.dart';
import 'package:physical_note/app/ui/page/feedback/feedback.dart';
import 'package:physical_note/app/ui/page/home/home.dart';
import 'package:physical_note/app/ui/page/main/main_screen_controller.dart';

class MainScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => DataController());
    Get.lazyPut(() => FeedbackController());

    /// API
    Get.lazyPut(() => HomeAPI());
    Get.lazyPut(() => WellnessAPI());
  }
}
