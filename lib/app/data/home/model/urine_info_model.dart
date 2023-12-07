import 'package:json_annotation/json_annotation.dart';

part 'urine_info_model.g.dart';

/// 운동 카테고리 조회 목록 아이템 모델.
@JsonSerializable()
class UrineInfoModel {
  final int? id;
  final int? differenceFat;
  final int? weight;
  final String? urine;
  final String? recordDate;

  UrineInfoModel({
    this.id,
    this.differenceFat,
    this.weight,
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
