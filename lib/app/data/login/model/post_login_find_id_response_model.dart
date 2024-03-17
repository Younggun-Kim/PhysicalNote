// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:physical_note/app/data/user/model/social_accounts_model.dart';

part 'post_login_find_id_response_model.g.dart';

@JsonSerializable()
class PostLoginFindIdResponseModel {
  final bool? status;
  final String? userLoginId;
  final String? message;
  final List<SocialAccountsModel>? accounts;


  PostLoginFindIdResponseModel({
    required this.status,
    required this.userLoginId,
    required this.message,
    required this.accounts,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostLoginFindIdResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostLoginFindIdResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostLoginFindIdResponseModelToJson(this);
}
