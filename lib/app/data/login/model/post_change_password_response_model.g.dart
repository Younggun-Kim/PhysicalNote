// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_change_password_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostChangePasswordResponseModel _$PostChangePasswordResponseModelFromJson(
        Map<String, dynamic> json) =>
    PostChangePasswordResponseModel(
      status: json['status'] as bool?,
      userLoginId: json['userLoginId'] as String?,
    );

Map<String, dynamic> _$PostChangePasswordResponseModelToJson(
        PostChangePasswordResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'userLoginId': instance.userLoginId,
    };
