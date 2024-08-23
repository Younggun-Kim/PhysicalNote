import 'package:json_annotation/json_annotation.dart';

part 'intensity_workout_response_model.g.dart';

@JsonSerializable()
class IntensityWorkoutResponseModel {
  final String? formattedWorkoutTime;
  final int? intensityLevel;
  final String? workoutTime;

  IntensityWorkoutResponseModel({
    required this.formattedWorkoutTime,
    required this.intensityLevel,
    required this.workoutTime,
  });

  factory IntensityWorkoutResponseModel.fromJson(Map<String, dynamic> json) =>
      _$IntensityWorkoutResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$IntensityWorkoutResponseModelToJson(this);
}
