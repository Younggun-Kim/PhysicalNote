// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_today_workout_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeTodayWorkoutItemModel _$HomeTodayWorkoutItemModelFromJson(
        Map<String, dynamic> json) =>
    HomeTodayWorkoutItemModel(
      id: (json['id'] as num?)?.toInt(),
      categoryName: json['categoryName'] as String?,
      workoutName: json['workoutName'] as String?,
      workoutTime: json['workoutTime'] as String?,
      address: json['address'] as String?,
      content: json['content'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      recordDate: json['recordDate'] as String?,
    );

Map<String, dynamic> _$HomeTodayWorkoutItemModelToJson(
        HomeTodayWorkoutItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryName': instance.categoryName,
      'workoutTime': instance.workoutTime,
      'workoutName': instance.workoutName,
      'address': instance.address,
      'content': instance.content,
      'images': instance.images,
      'recordDate': instance.recordDate,
    };
