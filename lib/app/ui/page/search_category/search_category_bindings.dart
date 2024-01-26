import 'package:get/get.dart';
import 'package:physical_note/app/data/workout/workout_api.dart';
import 'package:physical_note/app/ui/page/search_category/search_category.dart';

class SearchCategoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkoutAPI());
    Get.lazyPut(() => SearchCategoryController());
  }
}