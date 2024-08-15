// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_simple_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSimpleInfoModel _$UserSimpleInfoModelFromJson(Map<String, dynamic> json) =>
    UserSimpleInfoModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      teamName: json['teamName'] as String?,
      teamCoachName: json['teamCoachName'] as String?,
      profile: json['profile'] as String?,
    );

Map<String, dynamic> _$UserSimpleInfoModelToJson(
        UserSimpleInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'teamName': instance.teamName,
      'teamCoachName': instance.teamCoachName,
      'profile': instance.profile,
    };
