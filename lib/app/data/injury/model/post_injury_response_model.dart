

import 'package:json_annotation/json_annotation.dart';

part 'post_injury_response_model.g.dart';

@JsonSerializable()
class PostInjuryResponseModel {
  final int? id;
  final String? injuryType;
  final String? distinctionType;
  final String? bodyType;
  final String? bodyPart;
  final String? muscleType;
  final String? injuryLevel;
  final List<String>? painCharacteristicList;
  final List<String>? painTime;
  final String? comment;
  final String? recordDate;

  PostInjuryResponseModel({
    required this.id,
    required this.injuryType,
    required this.distinctionType,
    required this.bodyType,
    required this.bodyPart,
    required this.muscleType,
    required this.injuryLevel,
    required this.painCharacteristicList,
    required this.painTime,
    required this.comment,
    required this.recordDate,
  });


  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostInjuryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostInjuryResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostInjuryResponseModelToJson(this);
}
