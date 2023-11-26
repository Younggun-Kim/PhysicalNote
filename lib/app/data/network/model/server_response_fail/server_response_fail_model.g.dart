// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_response_fail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerResponseFailModel _$ServerResponseFailModelFromJson(
        Map<String, dynamic> json) =>
    ServerResponseFailModel(
      json['status'] as int,
      json['error'] as String,
      json['message'] as String,
      json['devMessage'] as String,
    );

Map<String, dynamic> _$ServerResponseFailModelToJson(
        ServerResponseFailModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'error': instance.error,
      'message': instance.message,
      'devMessage': instance.devMessage,
    };
