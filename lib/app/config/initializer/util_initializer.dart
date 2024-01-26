import 'package:get/get.dart';
import 'package:physical_note/app/utils/link/link.dart';

class UtilInitializer {
  UtilInitializer._();

  static Future<void> init() async {
    // Get.lazyPut(() => InLink());
    Get.lazyPut(() => OutLink());
    // Get.lazyPut(() => FormatUtil());
    // Get.lazyPut(() => DirectoryManager());
    // Get.lazyPut(() => DeviceInfoPlugin(), fenix: true);
    // await Get.putAsync(() => NotificationManager().init());
    // await Get.putAsync(() => PackageInfo.fromPlatform(), permanent: true);
  }
}
