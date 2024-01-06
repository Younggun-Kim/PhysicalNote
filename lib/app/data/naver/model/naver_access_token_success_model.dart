// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'naver_access_token_success_model.g.dart';

/// 네이버 토큰 가져오기 Succss Model
@JsonSerializable()
class NaverAccessTokenSuccessModel {
  @JsonKey(name: "access_token")
  final String accessToken;

  @JsonKey(name: "refresh_token")
  final String refreshToken;

  @JsonKey(name: "token_type")
  final String tokenType;

  @JsonKey(name: "expires_in")
  final String expiresIn;

  NaverAccessTokenSuccessModel({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory NaverAccessTokenSuccessModel.fromJson(Map<String, dynamic> json) =>
      _$NaverAccessTokenSuccessModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NaverAccessTokenSuccessModelToJson(this);
}
