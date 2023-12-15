import 'package:json_annotation/json_annotation.dart';

part 'injury_info_model.g.dart';

/// 운동 카테고리 조회 목록 아이템 모델.
@JsonSerializable()
class InjuryInfoModel {
  final int? id;
  final String? injuryType;
  final String? muscleType;
  final String? recordType;
  final String? injuryLevelType;

  final String? injuryLevelString;
  final String comment;

  InjuryInfoModel({
    required this.id,
    required this.injuryType,
    required this.muscleType,
    required this.recordType,
    required this.injuryLevelType,
    required this.injuryLevelString,
    required this.comment,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory InjuryInfoModel.fromJson(Map<String, dynamic> json) =>
      _$InjuryInfoModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$InjuryInfoModelToJson(this);
}
