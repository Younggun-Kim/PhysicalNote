// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_phone_authentication_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostPhoneAuthenticationResponseModel
    _$PostPhoneAuthenticationResponseModelFromJson(Map<String, dynamic> json) =>
        PostPhoneAuthenticationResponseModel(
          message: json['message'] as String?,
          status: json['status'] as bool?,
        );

Map<String, dynamic> _$PostPhoneAuthenticationResponseModelToJson(
        PostPhoneAuthenticationResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
    };
