// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_pass_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostPassResponseModel _$PostPassResponseModelFromJson(
        Map<String, dynamic> json) =>
    PostPassResponseModel(
      signed: json['signed'] as bool?,
      passInfo: json['passInfo'] == null
          ? null
          : PassInfoModel.fromJson(json['passInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostPassResponseModelToJson(
        PostPassResponseModel instance) =>
    <String, dynamic>{
      'signed': instance.signed,
      'passInfo': instance.passInfo,
    };
