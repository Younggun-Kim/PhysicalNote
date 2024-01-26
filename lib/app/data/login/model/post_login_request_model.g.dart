// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLoginRequestModel _$PostLoginRequestModelFromJson(
        Map<String, dynamic> json) =>
    PostLoginRequestModel(
      loginId: json['loginId'] as String?,
      password: json['password'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$PostLoginRequestModelToJson(
        PostLoginRequestModel instance) =>
    <String, dynamic>{
      'loginId': instance.loginId,
      'password': instance.password,
      'type': instance.type,
    };
