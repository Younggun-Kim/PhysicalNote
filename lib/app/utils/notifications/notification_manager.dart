import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'notification_detail.dart';

class NotificationManager extends GetxService {
  /// 알림 플러그인.
  late final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// 초기화 - Foreground Message.
  Future<NotificationManager> init() async {
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notifications');

    const initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
    return this;
  }

  /// 채널 생성.
  Future<void> createChannels() async {
    final android = NotificationDetail.message.android;
    if (android == null) {
      return;
    }
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(AndroidNotificationChannel(
          android.channelId,
          android.channelName,
          description: android.channelDescription,
          importance: android.importance,
        ));
  }

  /// 알림 생성.
  void show({
    required int id,
    required String title,
    required String body,
    required NotificationDetails details,
    String? payload,
  }) =>
      flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        details,
        payload: payload,
      );

  /// 알림 클릭 이벤트.
  void _onDidReceiveNotificationResponse(NotificationResponse details) async {
    final payload = details.payload;
    if (payload == null) {
      return;
    }
    if (payload.isEmpty) {
      return;
    }
    // final linkData = LinkData.fromStringJson(payload);
    // Get.find<InLink>().open(linkData);
  }
}
