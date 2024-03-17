// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'post_phone_authentication_response_model.g.dart';

@JsonSerializable()
class PostPhoneAuthenticationResponseModel {
  final String? message;
  final bool? status;

  PostPhoneAuthenticationResponseModel({
    required this.message,
    required this.status,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostPhoneAuthenticationResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$PostPhoneAuthenticationResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$PostPhoneAuthenticationResponseModelToJson(this);
}
