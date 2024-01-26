import 'package:json_annotation/json_annotation.dart';

part 'get_workout_position_detail_response_model.g.dart';

/// 운동 포지션 조회 응답 모델.
@JsonSerializable()
class GetWorkoutPositionDetailResponseModel {
  final int id;
  final int workoutId;
  final String name;

  GetWorkoutPositionDetailResponseModel({
    required this.id,
    required this.workoutId,
    required this.name,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory GetWorkoutPositionDetailResponseModel.fromJson(
      Map<String, dynamic> json) =>
      _$GetWorkoutPositionDetailResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$GetWorkoutPositionDetailResponseModelToJson(this);

}
