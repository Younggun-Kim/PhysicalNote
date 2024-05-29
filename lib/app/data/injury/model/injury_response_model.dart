import 'package:json_annotation/json_annotation.dart';

part 'injury_response_model.g.dart';

@JsonSerializable()
class InjuryResponseModel {
  final int? id;
  final String? injuryType;
  final String? distinctionType;
  final String? bodyType;
  final String? bodyPart;
  final String? muscleType;
  final String? injuryLevelType;
  final String? injuryLevelString;
  final List<String>? painCharacteristicList;
  final List<String>? painTimes;
  final String? comment;
  final String? recordDate;

  InjuryResponseModel({
    required this.id,
    required this.injuryType,
    required this.distinctionType,
    required this.bodyType,
    required this.bodyPart,
    required this.muscleType,
    required this.injuryLevelType,
    required this.injuryLevelString,
    required this.painCharacteristicList,
    required this.painTimes,
    required this.comment,
    required this.recordDate,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory InjuryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$InjuryResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$InjuryResponseModelToJson(this);
}
