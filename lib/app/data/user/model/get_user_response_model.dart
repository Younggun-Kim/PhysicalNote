// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'social_accounts_model.dart';

part 'get_user_response_model.g.dart';

/// 유저 정보 조회 응답 모델
@JsonSerializable()
class GetUserResponseModel {
  final int id;
  final String loginId;
  final String name;
  final String phone;
  final List<SocialAccountsModel> socialAccounts;
  final double rightValue;
  final double leftValue;
  final bool passVerify;
  final bool isRefresh;
  final String? birthDate;
  final String? profile;
  final String? gender;
  final String? teamName;
  final String? teamHeadCoach;
  final double? height;
  final double? weight;
  final String? token;

  GetUserResponseModel({
    required this.id,
    required this.loginId,
    required this.name,
    required this.phone,
    required this.socialAccounts,
    this.rightValue = 0.0,
    this.leftValue = 0.0,
    this.passVerify = false,
    this.isRefresh = false,
    this.birthDate,
    this.profile,
    this.gender,
    this.teamName,
    this.teamHeadCoach,
    this.height,
    this.weight,
    this.token,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory GetUserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetUserResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GetUserResponseModelToJson(this);
}
