import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/search_category/search_category.dart';

class SearchCategoryBindings extends Bindings {
  @override
  void dependencies() {
    return Get.lazyPut(() => SearchCategoryController());
  }
}