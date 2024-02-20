// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_user_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteUserResponseModel _$DeleteUserResponseModelFromJson(
        Map<String, dynamic> json) =>
    DeleteUserResponseModel(
      deleted: json['deleted'] as bool?,
      id: json['id'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$DeleteUserResponseModelToJson(
        DeleteUserResponseModel instance) =>
    <String, dynamic>{
      'deleted': instance.deleted,
      'id': instance.id,
      'message': instance.message,
    };
