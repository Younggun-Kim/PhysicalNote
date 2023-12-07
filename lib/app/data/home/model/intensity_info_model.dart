import 'package:json_annotation/json_annotation.dart';

part 'intensity_info_model.g.dart';

/// 운동 카테고리 조회 목록 아이템 모델.
@JsonSerializable()
class IntensityInfoModel {
  final int id;
  final int? level;
  final String? type;
  final String? recordDate;

  IntensityInfoModel({
    required this.id,
    this.type,
    this.level,
    this.recordDate,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory IntensityInfoModel.fromJson(Map<String, dynamic> json) =>
      _$IntensityInfoModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$IntensityInfoModelToJson(this);
}
