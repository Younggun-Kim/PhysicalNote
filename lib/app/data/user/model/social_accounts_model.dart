// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'social_accounts_model.g.dart';

/// 유저 소셜 타입 모델
@JsonSerializable()
class SocialAccountsModel {
  final String type;
  final String email;

  SocialAccountsModel({
    required this.type,
    required this.email,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory SocialAccountsModel.fromJson(Map<String, dynamic> json) =>
      _$SocialAccountsModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SocialAccountsModelToJson(this);
}
