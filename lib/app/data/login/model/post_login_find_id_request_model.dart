// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'post_login_find_id_request_model.g.dart';

@JsonSerializable()
class PostLoginFindIdRequestModel {
  final String code;
  final String loginType;

  PostLoginFindIdRequestModel({
    required this.code,
    required this.loginType,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostLoginFindIdRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PostLoginFindIdRequestModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostLoginFindIdRequestModelToJson(this);
}
