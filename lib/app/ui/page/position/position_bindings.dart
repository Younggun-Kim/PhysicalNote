import 'package:get/get.dart';
import 'package:physical_note/app/data/workout/workout_api.dart';

import 'position_controller.dart';

class PositionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkoutAPI());
    Get.lazyPut(() => PositionController());
  }

}