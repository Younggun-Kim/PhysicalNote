import 'package:json_annotation/json_annotation.dart';

part 'post_injury_request_model.g.dart';

/// 운동 카테고리 조회 목록 아이템 모델.
@JsonSerializable()
class PostInjuryRequestModel {
  final String? injuryType;
  final String? distinctionType;
  final String? bodyType;
  final String? bodyPart;
  final String? muscleType;
  final String? injuryLevel;
  final List<String>? painCharacteristicList;
  final String? painTime;
  final String? comment;
  final String? recordDate;

  PostInjuryRequestModel({
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
  factory PostInjuryRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PostInjuryRequestModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostInjuryRequestModelToJson(this);
}
