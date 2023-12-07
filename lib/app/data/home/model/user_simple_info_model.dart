import 'package:json_annotation/json_annotation.dart';

part 'user_simple_info_model.g.dart';

/// 운동 카테고리 조회 목록 아이템 모델.
@JsonSerializable()
class UserSimpleInfoModel {
  final int? id;
  final String? name;
  final String? teamName;
  final String? teamCoachName;
  final String? profile;

  UserSimpleInfoModel({
    this.id,
    this.name,
    this.teamName,
    this.teamCoachName,
    this.profile,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory UserSimpleInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserSimpleInfoModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserSimpleInfoModelToJson(this);
}
