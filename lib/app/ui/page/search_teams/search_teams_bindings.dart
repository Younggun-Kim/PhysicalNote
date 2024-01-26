import 'package:get/get.dart';
import 'package:physical_note/app/data/teams/teams_api.dart';
import 'search_teams_controller.dart';

class SearchTeamsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TeamsAPI());
    Get.lazyPut(() => SearchTeamsController());
  }
}