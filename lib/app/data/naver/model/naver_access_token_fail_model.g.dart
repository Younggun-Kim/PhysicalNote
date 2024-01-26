// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'naver_access_token_fail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NaverAccessTokenFailModel _$NaverAccessTokenFailModelFromJson(
        Map<String, dynamic> json) =>
    NaverAccessTokenFailModel(
      error: json['error'] as String,
      errorDescription: json['error_description'] as String,
    );

Map<String, dynamic> _$NaverAccessTokenFailModelToJson(
        NaverAccessTokenFailModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'error_description': instance.errorDescription,
    };
