
import 'package:physical_note/app/config/initializer/util_initializer.dart';

class AppInitializer {
  AppInitializer._();

  /// 초기화.
  static Future<void> init() async {
    // await StorageInitializer.init();
    // await NetworkInitializer.init();
    await UtilInitializer.init();
    // await FirebaseInitializer.init();
    // await ApiInitializer.init();
    // await CacheInitializer.init();
    // await BluetoothInitializer.init();
  }
}