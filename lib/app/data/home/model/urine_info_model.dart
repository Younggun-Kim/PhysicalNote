import 'package:json_annotation/json_annotation.dart';

part 'urine_info_model.g.dart';

/// 홈 소변 검사 모델.
@JsonSerializable()
class UrineInfoModel {
  final int? id;
  final double? weight;
  final double? differenceFat;
  final String? urine;
  final String? recordDate;

  UrineInfoModel({
    this.id,
    this.weight,
    this.differenceFat,
    this.urine,
    this.recordDate,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory UrineInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UrineInfoModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UrineInfoModelToJson(this);
}
