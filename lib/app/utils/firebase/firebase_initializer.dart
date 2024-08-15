import 'package:firebase_core/firebase_core.dart';
import 'package:physical_note/app/utils/firebase/fcm_initializer.dart';
import 'package:physical_note/app/utils/firebase/firebase_options.dart' as prod;
import 'package:physical_note/app/utils/firebase/firebase_options_dev.dart'
    as dev;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:physical_note/app/utils/utils.dart';

class FirebaseInitializer {
  FirebaseInitializer._();

  static Future<FirebaseOptions> _initializeFirebaseOption() async {
    PackageInfo package = await PackageInfo.fromPlatform();

    logger.i(package);

    if (package.packageName.contains('dev')) {
      return dev.DefaultFirebaseOptions.currentPlatform;
    } else {
      return prod.DefaultFirebaseOptions.currentPlatform;
    }
  }

  static Future<void> init() async {
    FirebaseOptions currentPlatform = await _initializeFirebaseOption();

    await Firebase.initializeApp(
      options: currentPlatform,
    );
    initCrashlytics();
    initPerformance();
    intiPushMessing();
  }

  /// Crashlytics 설정.
  static void initCrashlytics() async {
    // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    //
    // await FirebaseCrashlytics.instance
    //     .setCrashlyticsCollectionEnabled(kReleaseMode);
  }

  /// Performance 설정.
  static void initPerformance() {
    // empty..
  }

  /// FCM 설정.
  static void intiPushMessing() {
    FcmInitializer.init();
  }
}
