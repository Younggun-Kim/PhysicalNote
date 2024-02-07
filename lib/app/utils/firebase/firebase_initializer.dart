import 'package:firebase_core/firebase_core.dart';
import 'package:physical_note/app/utils/firebase/fcm_initializer.dart';

class FirebaseInitializer {
  FirebaseInitializer._();

  static Future<void> init() async {
    await Firebase.initializeApp();
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
