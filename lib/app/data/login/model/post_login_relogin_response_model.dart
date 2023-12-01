// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'post_login_relogin_response_model.g.dart';

@JsonSerializable()
class PostLoginReloginResponseModel {
  final String token;

  PostLoginReloginResponseModel({
    required this.token,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostLoginReloginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostLoginReloginResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostLoginReloginResponseModelToJson(this);
}
