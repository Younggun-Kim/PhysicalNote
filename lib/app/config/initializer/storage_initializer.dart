import 'package:get/get.dart';

import '../../data/user/user_storage.dart';

class StorageInitializer {
  StorageInitializer._();

  static Future<void> init() async {
    await Get.putAsync(
      () => UserStorage().init().then((value) => value as UserStorage),
    );
  }
}
