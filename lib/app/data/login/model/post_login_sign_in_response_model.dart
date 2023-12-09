// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'post_login_sign_in_response_model.g.dart';

@JsonSerializable()
class PostLoginSignInResponseModel {
  final int? userId;
  final String? loginId;
  final String? message;
  final String? name;
  final bool? status;
  final String? token;

  PostLoginSignInResponseModel({
    required this.userId,
    required this.loginId,
    required this.message,
    required this.name,
    required this.status,
    required this.token,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostLoginSignInResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostLoginSignInResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostLoginSignInResponseModelToJson(this);
}
