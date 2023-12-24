// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'post_intensity_response_model.g.dart';

@JsonSerializable()
class PostIntensityResponseModel {
  final int? id;
  final int? intensityLevel;
  final String? workoutTime;
  final String? workoutType;
  final String? recordDate;


  PostIntensityResponseModel({
    required this.id,
    required this.intensityLevel,
    required this.workoutTime,
    required this.workoutType,
    required this.recordDate,
  });

  factory PostIntensityResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostIntensityResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostIntensityResponseModelToJson(this);
}
