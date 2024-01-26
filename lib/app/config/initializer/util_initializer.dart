import 'package:get/get.dart';
import 'package:physical_note/app/utils/link/link.dart';

class UtilInitializer {
  UtilInitializer._();

  static Future<void> init() async {
    Get.lazyPut(() => OutLink());
  }
}
