import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/feedback/feedback_controller.dart';

class FeedbackBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeedbackController());
  }
}
