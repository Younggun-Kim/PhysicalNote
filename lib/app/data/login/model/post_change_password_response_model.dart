// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'post_change_password_response_model.g.dart';

@JsonSerializable()
/// 중복 확인 응답 모델.
class PostChangePasswordResponseModel {
  final bool? status;
  final String? userLoginId;

  PostChangePasswordResponseModel({
    required this.status,
    required this.userLoginId,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostChangePasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostChangePasswordResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostChangePasswordResponseModelToJson(this);

}
