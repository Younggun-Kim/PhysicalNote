// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'post_user_push_request_model.g.dart';

/// 유저 정보 조회 응답 모델
@JsonSerializable()
class PostUserPushRequestModel {
  final String? token;

  PostUserPushRequestModel({
    required this.token,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostUserPushRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PostUserPushRequestModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostUserPushRequestModelToJson(this);
}
