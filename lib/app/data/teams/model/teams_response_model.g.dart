// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamsResponseModel _$TeamsResponseModelFromJson(Map<String, dynamic> json) =>
    TeamsResponseModel(
      json['id'] as int,
      json['name'] as String,
      json['coachName'] as String?,
      json['profile'] as String?,
    );

Map<String, dynamic> _$TeamsResponseModelToJson(TeamsResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coachName': instance.coachName,
      'profile': instance.profile,
    };
