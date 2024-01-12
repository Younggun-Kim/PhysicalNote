import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/team_request/team_request_controller.dart';

class TeamRequestBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TeamRequestController());
  }
}