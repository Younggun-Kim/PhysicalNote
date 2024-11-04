// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:physical_note/app/config/constant/workout_type.dart';
import 'package:physical_note/app/data/intensity/model/post_intensity_request_model.dart';

part 'get_intensity_response_model.g.dart';

@JsonSerializable()
class GetIntensityListResponseModel {
  final List<GetIntensityResponseModel>? data;

  GetIntensityListResponseModel({required this.data});

  factory GetIntensityListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetIntensityListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetIntensityListResponseModelToJson(this);
}

@JsonSerializable()
class GetIntensityResponseModel {
  final int? id;
  final int? intensityType;
  final String? workoutTime;
  final String? workoutType;
  final String? recordDate;

  GetIntensityResponseModel({
    required this.id,
    required this.intensityType,
    required this.workoutTime,
    required this.workoutType,
    required this.recordDate,
  });

  factory GetIntensityResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetIntensityResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetIntensityResponseModelToJson(this);
}

extension GetIntensityListResponseModelExt on GetIntensityListResponseModel {
  GetIntensityResponseModel? getPhysical() {
    return data?.firstWhereOrNull(
      (e) => e.workoutType == WorkoutType.physical.remote,
    );
  }

  GetIntensityResponseModel? getSports() {
    return data?.firstWhereOrNull(
      (e) => e.workoutType == WorkoutType.sports.remote,
    );
  }
}

extension GetIntensityResponseModelExt on GetIntensityResponseModel {
  PostIntensityRequestModel toRequestModel() {
    return PostIntensityRequestModel(
      intensityLevel: intensityType,
      workoutTime: workoutTime,
      workoutType: workoutType,
      recordDate: recordDate,
    );
  }
}
