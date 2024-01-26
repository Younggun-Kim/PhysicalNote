// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'post_login_response_model.g.dart';

@JsonSerializable()
class PostLoginResponseModel {
  final String? token;
  final int? userId;
  final String? loginId;
  final String? name;

  PostLoginResponseModel({
    this.token,
    this.userId,
    this.loginId,
    this.name,
  });


  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostLoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostLoginResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostLoginResponseModelToJson(this);

}
