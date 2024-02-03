import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/dialog_page/dialog_page.dart';

class DialogPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DialogPageController());
  }
}
