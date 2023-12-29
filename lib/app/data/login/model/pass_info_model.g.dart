// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pass_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassInfoModel _$PassInfoModelFromJson(Map<String, dynamic> json) =>
    PassInfoModel(
      birthdate: json['birthdate'] as String?,
      di: json['di'] as String?,
      exp: json['exp'] as int?,
      gender: json['gender'] as String?,
      mobileno: json['mobileno'] as String?,
      nationalinfo: json['nationalinfo'] as String?,
      resultcode: json['resultcode'] as String?,
      utf8_name: json['utf8_name'] as String?,
    );

Map<String, dynamic> _$PassInfoModelToJson(PassInfoModel instance) =>
    <String, dynamic>{
      'birthdate': instance.birthdate,
      'di': instance.di,
      'exp': instance.exp,
      'gender': instance.gender,
      'mobileno': instance.mobileno,
      'nationalinfo': instance.nationalinfo,
      'resultcode': instance.resultcode,
      'utf8_name': instance.utf8_name,
    };
