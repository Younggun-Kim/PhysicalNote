import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

import 'link_screen.dart';
import 'link_type.dart';

part 'link_data.g.dart';

@JsonSerializable()
class LinkData {
  final LinkType linkType;

  final LinkScreen? screen;

  final int? targetId;

  const LinkData({required this.linkType, this.screen, this.targetId});

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
    int? targetId;

    try {
      targetId = int.tryParse(data['targetId']);
    } catch (e) {
      logger.e(e);
    }

    logger.i(screen);

    return LinkData(
      linkType: LinkType.inAppLink,
      screen: screen,
      targetId: targetId,
    );
  }
}
