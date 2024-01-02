// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_user_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostUserRequestModel _$PostUserRequestModelFromJson(
        Map<String, dynamic> json) =>
    PostUserRequestModel(
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      leftValue: json['leftValue'] as int,
      rightValue: json['rightValue'] as int,
      teamId: json['teamId'] as int,
      positionIds:
          (json['positionIds'] as List<dynamic>).map((e) => e as int).toList(),
      workoutId: json['workoutId'] as int,
      userType: json['userType'] as String,
      passCode: json['passCode'] as String?,
      profile: json['profile'] as String?,
    );

Map<String, dynamic> _$PostUserRequestModelToJson(
        PostUserRequestModel instance) =>
    <String, dynamic>{
      'height': instance.height,
      'weight': instance.weight,
      'leftValue': instance.leftValue,
      'rightValue': instance.rightValue,
      'teamId': instance.teamId,
      'positionIds': instance.positionIds,
      'profile': instance.profile,
      'workoutId': instance.workoutId,
      'userType': instance.userType,
      'passCode': instance.passCode,
    };
