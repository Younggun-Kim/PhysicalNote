// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_login_sign_in_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLoginSignInRequestModel _$PostLoginSignInRequestModelFromJson(
        Map<String, dynamic> json) =>
    PostLoginSignInRequestModel(
      loginId: json['loginId'] as String?,
      passCode: json['passCode'] as String?,
      password: json['password'] as String,
      type: json['type'] as String,
      name: json['name'] as String?,
      cellphoneNo: json['cellphoneNo'] as String?,
      birthDate: json['birthDate'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$PostLoginSignInRequestModelToJson(
        PostLoginSignInRequestModel instance) =>
    <String, dynamic>{
      'loginId': instance.loginId,
      'passCode': instance.passCode,
      'password': instance.password,
      'type': instance.type,
      'name': instance.name,
      'cellphoneNo': instance.cellphoneNo,
      'birthDate': instance.birthDate,
      'gender': instance.gender,
    };
