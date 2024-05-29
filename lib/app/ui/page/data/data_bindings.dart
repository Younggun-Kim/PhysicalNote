import 'package:get/get.dart';
import 'package:physical_note/app/data/injury/injury_api.dart';
import 'package:physical_note/app/data/intensity/intensity_api.dart';
import 'package:physical_note/app/data/wellness/wellness_api.dart';
import 'package:physical_note/app/ui/page/data/data_controller.dart';
import 'package:physical_note/app/ui/page/injury_check/injury_check.dart';

class DataBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DataController());
    Get.lazyPut(() => InjuryCheckController());
    Get.lazyPut(() => WellnessAPI());
    Get.lazyPut(() => InjuryAPI());
    Get.lazyPut(() => IntensityAPI());
  }
}
