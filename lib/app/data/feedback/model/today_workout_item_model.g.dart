// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'today_workout_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayWorkoutItemModel _$TodayWorkoutItemModelFromJson(
        Map<String, dynamic> json) =>
    TodayWorkoutItemModel(
      id: (json['id'] as num?)?.toInt(),
      categoryName: json['categoryName'] as String?,
      categoryColorCode: json['categoryColorCode'] as String?,
      workoutTime: json['workoutTime'] as String?,
      address: json['address'] as String?,
      content: json['content'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TodayWorkoutItemModelToJson(
        TodayWorkoutItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryName': instance.categoryName,
      'categoryColorCode': instance.categoryColorCode,
      'workoutTime': instance.workoutTime,
      'address': instance.address,
      'content': instance.content,
      'images': instance.images,
    };
