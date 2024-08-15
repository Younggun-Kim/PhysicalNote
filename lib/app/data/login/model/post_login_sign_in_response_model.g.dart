// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_login_sign_in_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLoginSignInResponseModel _$PostLoginSignInResponseModelFromJson(
        Map<String, dynamic> json) =>
    PostLoginSignInResponseModel(
      userId: (json['userId'] as num?)?.toInt(),
      loginId: json['loginId'] as String?,
      message: json['message'] as String?,
      name: json['name'] as String?,
      status: json['status'] as bool?,
      token: json['token'] as String?,
      birthDate: json['birthDate'] as String?,
    );

Map<String, dynamic> _$PostLoginSignInResponseModelToJson(
        PostLoginSignInResponseModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'loginId': instance.loginId,
      'message': instance.message,
      'name': instance.name,
      'status': instance.status,
      'token': instance.token,
      'birthDate': instance.birthDate,
    };
