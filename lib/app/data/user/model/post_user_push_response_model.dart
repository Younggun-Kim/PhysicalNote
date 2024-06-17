// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'post_user_push_response_model.g.dart';

/// 유저 정보 조회 응답 모델
@JsonSerializable()
class PostUserPushResponseModel {
  final String? token;

  PostUserPushResponseModel({
    required this.token,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostUserPushResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostUserPushResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostUserPushResponseModelToJson(this);
}
