// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'post_user_request_model.g.dart';

/// 유저 정보 조회 응답 모델
@JsonSerializable()
class PostUserRequestModel {
  final double height;
  final double weight;
  final int leftValue;
  final int rightValue;
  final int teamId;
  final List<int> positionIds;
  final String? profile;

  PostUserRequestModel({
    required this.height,
    required this.weight,
    required this.leftValue,
    required this.rightValue,
    required this.teamId,
    required this.positionIds,
    this.profile,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostUserRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PostUserRequestModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostUserRequestModelToJson(this);
}
