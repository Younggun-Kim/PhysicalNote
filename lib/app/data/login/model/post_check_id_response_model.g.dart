// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_check_id_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCheckIdResponseModel _$PostCheckIdResponseModelFromJson(
        Map<String, dynamic> json) =>
    PostCheckIdResponseModel(
      duplicate: json['duplicate'] as bool?,
      loginId: json['loginId'] as String?,
    );

Map<String, dynamic> _$PostCheckIdResponseModelToJson(
        PostCheckIdResponseModel instance) =>
    <String, dynamic>{
      'duplicate': instance.duplicate,
      'loginId': instance.loginId,
    };
