// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_term_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTermResponseModel _$GetTermResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetTermResponseModel(
      id: (json['id'] as num?)?.toInt(),
      category: json['category'] as String?,
      content: json['content'] as String?,
      startDate: json['startDate'] as String?,
      version: json['version'] as String?,
    );

Map<String, dynamic> _$GetTermResponseModelToJson(
        GetTermResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'content': instance.content,
      'startDate': instance.startDate,
      'version': instance.version,
    };
