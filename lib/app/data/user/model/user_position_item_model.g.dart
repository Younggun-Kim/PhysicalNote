// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_position_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPositionItemModel _$UserPositionItemModelFromJson(
        Map<String, dynamic> json) =>
    UserPositionItemModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserPositionItemModelToJson(
        UserPositionItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userId': instance.userId,
    };
