import 'package:json_annotation/json_annotation.dart';

part 'today_workout_item_model.g.dart';

@JsonSerializable()
class TodayWorkoutItemModel {
  final int? id;
  final String? categoryName;
  final String? categoryColorCode;
  final String? workoutTime;
  final String? address;
  final String? content;
  final List<String>? images;

  TodayWorkoutItemModel({
    required this.id,
    required this.categoryName,
    required this.categoryColorCode,
    required this.workoutTime,
    required this.address,
    required this.content,
    required this.images,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory TodayWorkoutItemModel.fromJson(Map<String, dynamic> json) =>
      _$TodayWorkoutItemModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TodayWorkoutItemModelToJson(this);

}
