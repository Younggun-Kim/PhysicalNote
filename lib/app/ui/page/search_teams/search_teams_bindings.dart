import 'package:get/get.dart';
import 'search_teams_controller.dart';

class SearchTeamsBindings extends Bindings {
  @override
  void dependencies() {
    return Get.lazyPut(() => SearchTeamsController());
  }
}