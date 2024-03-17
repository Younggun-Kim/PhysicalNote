// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_login_find_id_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLoginFindIdResponseModel _$PostLoginFindIdResponseModelFromJson(
        Map<String, dynamic> json) =>
    PostLoginFindIdResponseModel(
      status: json['status'] as bool?,
      userLoginId: json['userLoginId'] as String?,
      message: json['message'] as String?,
      accounts: (json['accounts'] as List<dynamic>?)
          ?.map((e) => SocialAccountsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostLoginFindIdResponseModelToJson(
        PostLoginFindIdResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'userLoginId': instance.userLoginId,
      'message': instance.message,
      'accounts': instance.accounts,
    };
