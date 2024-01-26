import 'package:physical_note/app/config/initializer/util_initializer.dart';

import 'storage_initializer.dart';

class AppInitializer {
  AppInitializer._();

  /// 초기화.
  static Future<void> init() async {
    await StorageInitializer.init();
    await UtilInitializer.init();
  }
}
