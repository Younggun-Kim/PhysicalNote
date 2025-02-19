import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_api_availability/google_api_availability.dart';
import 'package:physical_note/app/utils/link/in_link.dart';
import 'package:physical_note/app/utils/link/model/link_data.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

import '../notifications/notification_detail.dart';
import '../notifications/notification_manager.dart';

/// 포그라운드 메시지 처리.
void _onMessage(RemoteMessage message) {
  logger.d("_onMessage: ${message.data}");
  Get.find<NotificationManager>().show(
    id: message.hashCode,
    title: message.notification?.title ?? "",
    body: message.notification?.body ?? "",
    details: NotificationDetail.message,
    payload: json.encode(message.toLinkData()),
  );
}

/// 백그라운드 메시지 처리.
@pragma('vm:entry-point')
Future<void> _onBackgroundMessage(RemoteMessage message) async {
  logger.d("_handleBackgroundMessage: ${message.data}");
}

/// 백그라운드에서 앱 실행 처리.
void _onMessageOpenedApp(RemoteMessage message) {
  logger.d("_onMessageOpenedApp");
  Get.find<InLink>().open(message.toLinkData());
}

class FcmInitializer {
  FcmInitializer._();


  /// Google Play Service가 이용 가능한지 검사.
  /// FCM 에러날 때 확인이 필요
  static Future<bool> checkGooglePlayService() async {
    final availability = await GoogleApiAvailability.instance
        .checkGooglePlayServicesAvailability();

    return availability == GooglePlayServicesAvailability.success;
  }

  /// 초기화.
  static void init() async {
    try {
      logger.i('CheckGooglePlayServices : ${await checkGooglePlayService()}');
      if(await checkGooglePlayService()) {

      }
      // GoogleApiAvailability.makeGooglePlayServicesAvailable()
      final token = await FirebaseMessaging.instance.getToken();

      if (kDebugMode) {
        print("🫥🫥🫥🫥🫥FCM TOKEN🫥🫥🫥🫥🫥");
        print("$token");
      }

      // IOS background 권한 체킹 , 요청
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen(_onMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
      FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
    } catch (e) {
      logger.e('FCM Init Error: ${e}');
    }
  }
}
