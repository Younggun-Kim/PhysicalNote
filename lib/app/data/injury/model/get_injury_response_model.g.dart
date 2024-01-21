// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_injury_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetInjuryResponseModel _$GetInjuryResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetInjuryResponseModel(
      list: (json['list'] as List<dynamic>)
          .map((e) => InjuryResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetInjuryResponseModelToJson(
        GetInjuryResponseModel instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
