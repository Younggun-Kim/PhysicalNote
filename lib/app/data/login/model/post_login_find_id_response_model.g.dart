// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_login_find_id_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLoginFindIdResponseModel _$PostLoginFindIdResponseModelFromJson(
        Map<String, dynamic> json) =>
    PostLoginFindIdResponseModel(
      accounts: (json['accounts'] as List<dynamic>?)
          ?.map((e) => SocialAccountsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as bool?,
      userId: json['userId'] as int?,
    );

Map<String, dynamic> _$PostLoginFindIdResponseModelToJson(
        PostLoginFindIdResponseModel instance) =>
    <String, dynamic>{
      'accounts': instance.accounts,
      'status': instance.status,
      'userId': instance.userId,
    };
