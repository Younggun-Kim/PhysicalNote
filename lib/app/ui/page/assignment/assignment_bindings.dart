import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/assignment/assignment_controller.dart';

class AssignmentBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AssignmentController());
  }
}
