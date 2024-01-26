// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'user_position_item_model.g.dart';

/// 유저 정보 조회 응답 모델
@JsonSerializable()
class UserPositionItemModel {
  final int? id;
  final String? name;
  final int? userId;

  UserPositionItemModel({
    required this.id,
    required this.name,
    required this.userId,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory UserPositionItemModel.fromJson(Map<String, dynamic> json) =>
      _$UserPositionItemModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserPositionItemModelToJson(this);
}
