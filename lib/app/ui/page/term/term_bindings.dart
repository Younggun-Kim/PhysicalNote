import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/term/term_controller.dart';

class TermBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermController());
  }
}
