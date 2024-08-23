import 'package:json_annotation/json_annotation.dart';

import 'intensity_workout_response_model.dart';

part 'get_intensity_list_item_response_model.g.dart';

@JsonSerializable()
class GetIntensityListItemResponseModel {
  final String? date;
  final String? workoutType;
  final IntensityWorkoutResponseModel? physical;
  final IntensityWorkoutResponseModel? sports;

  GetIntensityListItemResponseModel({
    required this.date,
    required this.workoutType,
    required this.physical,
    required this.sports,
  });

  factory GetIntensityListItemResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$GetIntensityListItemResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetIntensityListItemResponseModelToJson(this);
}
