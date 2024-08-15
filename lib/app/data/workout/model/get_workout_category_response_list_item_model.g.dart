// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_workout_category_response_list_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWorkoutCategoryResponseListItemModel
    _$GetWorkoutCategoryResponseListItemModelFromJson(
            Map<String, dynamic> json) =>
        GetWorkoutCategoryResponseListItemModel(
          (json['id'] as num).toInt(),
          json['name'] as String,
        );

Map<String, dynamic> _$GetWorkoutCategoryResponseListItemModelToJson(
        GetWorkoutCategoryResponseListItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
