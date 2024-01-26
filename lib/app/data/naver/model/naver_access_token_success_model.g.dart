// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'naver_access_token_success_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NaverAccessTokenSuccessModel _$NaverAccessTokenSuccessModelFromJson(
        Map<String, dynamic> json) =>
    NaverAccessTokenSuccessModel(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String,
      expiresIn: json['expires_in'] as String,
    );

Map<String, dynamic> _$NaverAccessTokenSuccessModelToJson(
        NaverAccessTokenSuccessModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
    };
