// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLoginResponseModel _$PostLoginResponseModelFromJson(
        Map<String, dynamic> json) =>
    PostLoginResponseModel(
      token: json['token'] as String?,
      userId: json['userId'] as int?,
      loginId: json['loginId'] as String?,
      role: json['role'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PostLoginResponseModelToJson(
        PostLoginResponseModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userId': instance.userId,
      'loginId': instance.loginId,
      'role': instance.role,
      'name': instance.name,
    };
