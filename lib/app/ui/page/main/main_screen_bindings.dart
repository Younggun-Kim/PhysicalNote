import 'package:get/get.dart';
import 'package:physical_note/app/data/feedback/feedback_api.dart';
import 'package:physical_note/app/data/home/home_api.dart';
import 'package:physical_note/app/data/injury/injury_api.dart';
import 'package:physical_note/app/data/intensity/intensity_api.dart';
import 'package:physical_note/app/data/wellness/wellness_api.dart';
import 'package:physical_note/app/ui/page/data/data.dart';
import 'package:physical_note/app/ui/page/feedback/feedback.dart';
import 'package:physical_note/app/ui/page/history/history.dart';
import 'package:physical_note/app/ui/page/home/home.dart';
import 'package:physical_note/app/ui/page/main/main_screen_controller.dart';

class MainScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainScreenController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => DataController());
    Get.lazyPut(() => HistoryController());
    Get.lazyPut(() => FeedbackController());

    /// API
    Get.lazyPut(() => HomeAPI());
    Get.lazyPut(() => WellnessAPI());
    Get.lazyPut(() => IntensityAPI());
    Get.lazyPut(() => InjuryAPI());
    Get.lazyPut(() => FeedbackAPI());
  }
}
