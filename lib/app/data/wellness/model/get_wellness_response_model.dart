// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'get_wellness_response_model.g.dart';

/// 웰리니스 조회 응답 모델
@JsonSerializable()
class GetWellnessResponseModel {
  final int? id;
  final double? bodyFat;
  final double? emptyStomachWeight;
  final int? fatigue;
  final int? muscleSoreness;
  final int? sleep;
  final int? stress;
  final int? urine;
  final String? recordDate;

  GetWellnessResponseModel({
    required this.id,
    required this.bodyFat,
    required this.emptyStomachWeight,
    required this.fatigue,
    required this.muscleSoreness,
    required this.sleep,
    required this.stress,
    required this.urine,
    required this.recordDate,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory GetWellnessResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetWellnessResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GetWellnessResponseModelToJson(this);
}
