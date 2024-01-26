import 'package:json_annotation/json_annotation.dart';

part 'post_injury_request_model.g.dart';

@JsonSerializable()
class PostInjuryRequestModel {
  final String? injuryType;
  final String? distinctionType;
  final String? bodyType;
  final String? bodyPart;
  final String? muscleType;
  final String? injuryLevel;
  final List<String>? painCharacteristicList;
  final List<String>? painTimes;
  final String? comment;
  final String? recordDate;

  PostInjuryRequestModel({
    required this.injuryType,
    this.distinctionType,
    this.bodyType,
    this.bodyPart,
    this.muscleType,
    this.injuryLevel,
    this.painCharacteristicList,
    this.painTimes,
    required this.comment,
    required this.recordDate,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostInjuryRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PostInjuryRequestModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostInjuryRequestModelToJson(this);
}
