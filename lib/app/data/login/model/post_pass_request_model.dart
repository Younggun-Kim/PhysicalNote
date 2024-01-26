// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'post_pass_request_model.g.dart';

@JsonSerializable()
class PostPassRequestModel {
  final String code;
  final String loginType;


  PostPassRequestModel({
    required this.code,
    required this.loginType,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostPassRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PostPassRequestModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostPassRequestModelToJson(this);
}
