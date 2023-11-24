// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'post_login_request_model.g.dart';

@JsonSerializable()
class PostLoginRequestModel {
  final String loginId;
  final String password;
  final String type;

  PostLoginRequestModel({
    required this.loginId,
    required this.password,
    required this.type,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostLoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PostLoginRequestModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostLoginRequestModelToJson(this);
}
