// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkData _$LinkDataFromJson(Map<String, dynamic> json) => LinkData(
      linkType: $enumDecode(_$LinkTypeEnumMap, json['linkType']),
      screen: $enumDecodeNullable(_$LinkScreenEnumMap, json['screen']),
      targetId: json['targetId'] as int?,
    );

Map<String, dynamic> _$LinkDataToJson(LinkData instance) => <String, dynamic>{
      'linkType': _$LinkTypeEnumMap[instance.linkType]!,
      'screen': _$LinkScreenEnumMap[instance.screen],
      'targetId': instance.targetId,
    };

const _$LinkTypeEnumMap = {
  LinkType.inLink: 'inLink',
  LinkType.outLink: 'outLink',
  LinkType.inAppLink: 'inAppLink',
};

const _$LinkScreenEnumMap = {
  LinkScreen.home: 'home',
  LinkScreen.data: 'data',
  LinkScreen.feedback: 'feedback',
  LinkScreen.injury: 'injury',
};
