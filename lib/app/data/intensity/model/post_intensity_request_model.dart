// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'post_intensity_request_model.g.dart';

@JsonSerializable()
class PostIntensityRequestModel {
  final int? intensityLevel;
  final String? workoutTime;
  final String? workoutType;
  final String? recordDate;


  PostIntensityRequestModel({
    required this.intensityLevel,
    required this.workoutTime,
    required this.workoutType,
    required this.recordDate,
  });

  factory PostIntensityRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PostIntensityRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostIntensityRequestModelToJson(this);
}
