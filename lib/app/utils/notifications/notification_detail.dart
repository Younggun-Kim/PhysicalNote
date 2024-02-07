import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/colors/color_res.dart';
import 'package:physical_note/app/resources/strings/translations.dart';

class NotificationDetail {
  NotificationDetail._();

  /// 메시지 타입.
  static NotificationDetails get message => NotificationDetails(
        android: AndroidNotificationDetails(
          "message",
          StringRes.message.tr,
          channelDescription: StringRes.messageChannelDescription.tr,
          importance: Importance.max,
          priority: Priority.high,
          color: ColorRes.white,
        ),
        iOS: const DarwinNotificationDetails(),
      );
}
