// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_pass_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostPassRequestModel _$PostPassRequestModelFromJson(
        Map<String, dynamic> json) =>
    PostPassRequestModel(
      code: json['code'] as String,
      loginType: json['loginType'] as String,
    );

Map<String, dynamic> _$PostPassRequestModelToJson(
        PostPassRequestModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'loginType': instance.loginType,
    };
