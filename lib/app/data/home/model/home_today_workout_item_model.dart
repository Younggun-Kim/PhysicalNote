import 'package:json_annotation/json_annotation.dart';

part 'home_today_workout_item_model.g.dart';

@JsonSerializable()
class HomeTodayWorkoutItemModel {
  final int? id;
  final String? categoryName;
  final String? workoutTime;
  final String? workoutName;
  final String? address;
  final String? content;
  final List<String>? images;
  final String? recordDate;

  HomeTodayWorkoutItemModel({
    required this.id,
    required this.categoryName,
    required this.workoutName,
    required this.workoutTime,
    required this.address,
    required this.content,
    required this.images,
    required this.recordDate,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory HomeTodayWorkoutItemModel.fromJson(Map<String, dynamic> json) =>
      _$HomeTodayWorkoutItemModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$HomeTodayWorkoutItemModelToJson(this);

}
