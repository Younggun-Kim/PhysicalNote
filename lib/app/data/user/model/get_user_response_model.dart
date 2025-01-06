// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:physical_note/app/data/user/model/user_position_item_model.dart';
import 'social_accounts_model.dart';

part 'get_user_response_model.g.dart';

/// 유저 정보 조회 응답 모델
@JsonSerializable()
class GetUserResponseModel {
  final String? birthDate;
  final String? gender;
  final double? height;
  final int? id;
  final bool? isRefresh;
  final double? leftValue;
  final String? loginId;
  final String? name;
  final bool? passVerify;
  final String? phone;
  final List<UserPositionItemModel>? positions;
  final String? profile;
  final double? rightValue;
  final List<SocialAccountsModel>? socialAccounts;
  final String? teamHeadCoach;
  final int? teamId;
  final String? teamName;
  final bool? teamRequestYn;
  final String? token;
  final String? userType;
  final double? weight;
  final int? workoutId;
  final String? useMain;

  GetUserResponseModel({
    required this.birthDate,
    required this.gender,
    required this.height,
    required this.id,
    required this.isRefresh,
    required this.leftValue,
    required this.loginId,
    required this.name,
    required this.passVerify,
    required this.phone,
    required this.positions,
    required this.profile,
    required this.rightValue,
    required this.socialAccounts,
    required this.teamHeadCoach,
    required this.teamId,
    required this.teamName,
    required this.teamRequestYn,
    required this.token,
    required this.userType,
    required this.weight,
    required this.workoutId,
    required this.useMain,
  });

  String? teamAndCoach() {
    if (teamName != null && teamHeadCoach != null) {
      return "$teamName / $teamHeadCoach";
    } else if (teamName != null) {
      return teamName;
    } else if (teamHeadCoach != null) {
      return teamHeadCoach;
    } else {
      return null;
    }
  }

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory GetUserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetUserResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GetUserResponseModelToJson(this);
}
