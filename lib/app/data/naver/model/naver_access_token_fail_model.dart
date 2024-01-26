// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'naver_access_token_fail_model.g.dart';

/// 네이버 토큰 가져오기 Succss Model
@JsonSerializable()
class NaverAccessTokenFailModel {
  /// {"error":"invalid_request","error_description":"no valid data in session"}
  final String error;

  @JsonKey(name: "error_description")
  final String errorDescription;

  NaverAccessTokenFailModel({
    required this.error,
    required this.errorDescription,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory NaverAccessTokenFailModel.fromJson(Map<String, dynamic> json) =>
      _$NaverAccessTokenFailModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NaverAccessTokenFailModelToJson(this);
}
