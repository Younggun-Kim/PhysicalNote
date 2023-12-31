// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_change_password_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostChangePasswordResponseModel _$PostChangePasswordResponseModelFromJson(
        Map<String, dynamic> json) =>
    PostChangePasswordResponseModel(
      status: json['status'] as bool?,
      userId: json['userId'] as int?,
    );

Map<String, dynamic> _$PostChangePasswordResponseModelToJson(
        PostChangePasswordResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'userId': instance.userId,
    };
