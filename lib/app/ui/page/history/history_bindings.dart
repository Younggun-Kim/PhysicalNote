import 'package:get/get.dart';
import 'package:physical_note/app/data/injury/injury_api.dart';
import 'package:physical_note/app/data/intensity/intensity_api.dart';
import 'package:physical_note/app/data/wellness/wellness_api.dart';
import 'package:physical_note/app/ui/page/history/history_controller.dart';

class HistoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryController());

    // API DI
    Get.lazyPut(() => WellnessAPI());
    Get.lazyPut(() => IntensityAPI());
    Get.lazyPut(() => InjuryAPI());
  }
}
