// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'post_login_sign_in_request_model.g.dart';

@JsonSerializable()
class PostLoginSignInRequestModel {
  final String? loginId;
  final String? passCode;
  final String password;
  final String type;

  PostLoginSignInRequestModel({
    required this.loginId,
    required this.passCode,
    required this.password,
    required this.type,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostLoginSignInRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PostLoginSignInRequestModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostLoginSignInRequestModelToJson(this);
}
