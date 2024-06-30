import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:physical_note/app/utils/link/model/link_data_detail.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

import 'link_screen.dart';
import 'link_type.dart';

part 'link_data.g.dart';

@JsonSerializable()
class LinkData {
  final LinkType linkType;

  final LinkScreen? screen;

  final DateTime? recordDate;

  const LinkData({required this.linkType, this.screen, this.recordDate});

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory LinkData.fromJson(Map<String, dynamic> json) =>
      _$LinkDataFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LinkDataToJson(this);

  factory LinkData.fromStringJson(String json) =>
      LinkData.fromJson(jsonDecode(json));
}

extension RemoteMessageExt on RemoteMessage {
  LinkData toLinkData() {
    final screen = LinkScreen.from(data['screen']);
    DateTime? recordDate;

    try {
      final linkDataDetail = LinkDataDetail.fromStringJson(data['data']);
      final recordDateStr = linkDataDetail.recordDate;
      if(recordDateStr != null) {
        recordDate = DateFormat('yyyy-MM-dd').parse(recordDateStr);
      }
    } catch(e) {
      logger.e(e);
    }

    return LinkData(
      linkType: LinkType.inAppLink,
      screen: screen,
      recordDate: recordDate,
    );
  }
}
