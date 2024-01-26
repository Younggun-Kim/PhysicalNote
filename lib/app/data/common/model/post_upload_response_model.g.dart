// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_upload_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostUploadResponseModel _$PostUploadResponseModelFromJson(
        Map<String, dynamic> json) =>
    PostUploadResponseModel(
      uploaded: json['uploaded'] as bool?,
      url: (json['url'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PostUploadResponseModelToJson(
        PostUploadResponseModel instance) =>
    <String, dynamic>{
      'uploaded': instance.uploaded,
      'url': instance.url,
    };
