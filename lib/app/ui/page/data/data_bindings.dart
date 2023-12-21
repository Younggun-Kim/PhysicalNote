import 'package:get/get.dart';
import 'package:physical_note/app/data/wellness/wellness_api.dart';
import 'package:physical_note/app/ui/page/data/data_controller.dart';

class DataBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DataController());
    Get.lazyPut(() => WellnessAPI());
  }
}
