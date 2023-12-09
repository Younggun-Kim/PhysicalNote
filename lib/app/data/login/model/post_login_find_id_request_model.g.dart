// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_login_find_id_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLoginFindIdRequestModel _$PostLoginFindIdRequestModelFromJson(
        Map<String, dynamic> json) =>
    PostLoginFindIdRequestModel(
      code: json['code'] as String,
      loginType: json['loginType'] as String,
    );

Map<String, dynamic> _$PostLoginFindIdRequestModelToJson(
        PostLoginFindIdRequestModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'loginType': instance.loginType,
    };
