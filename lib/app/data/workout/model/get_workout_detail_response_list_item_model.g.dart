// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_workout_detail_response_list_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWorkoutDetailResponseItemModel _$GetWorkoutDetailResponseItemModelFromJson(
        Map<String, dynamic> json) =>
    GetWorkoutDetailResponseItemModel(
      (json['id'] as num).toInt(),
      json['name'] as String,
      (json['categoryId'] as num).toInt(),
      json['useMain'] as String,
    );

Map<String, dynamic> _$GetWorkoutDetailResponseItemModelToJson(
        GetWorkoutDetailResponseItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categoryId': instance.categoryId,
      'useMain': instance.useMain,
    };
