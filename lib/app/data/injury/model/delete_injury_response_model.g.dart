// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_injury_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteInjuryResponseModel _$DeleteInjuryResponseModelFromJson(
        Map<String, dynamic> json) =>
    DeleteInjuryResponseModel(
      deleted: json['deleted'] as bool?,
      id: (json['id'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DeleteInjuryResponseModelToJson(
        DeleteInjuryResponseModel instance) =>
    <String, dynamic>{
      'deleted': instance.deleted,
      'id': instance.id,
      'message': instance.message,
    };
