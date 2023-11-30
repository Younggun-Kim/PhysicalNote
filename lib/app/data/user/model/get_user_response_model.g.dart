// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserResponseModel _$GetUserResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetUserResponseModel(
      id: json['id'] as int,
      loginId: json['loginId'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      socialAccounts: (json['socialAccounts'] as List<dynamic>)
          .map((e) => SocialAccountsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      rightValue: (json['rightValue'] as num?)?.toDouble() ?? 0.0,
      leftValue: (json['leftValue'] as num?)?.toDouble() ?? 0.0,
      passVerify: json['passVerify'] as bool? ?? false,
      isRefresh: json['isRefresh'] as bool? ?? false,
      birthDate: json['birthDate'] as String?,
      profile: json['profile'] as String?,
      gender: json['gender'] as String?,
      teamName: json['teamName'] as String?,
      teamHeadCoach: json['teamHeadCoach'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$GetUserResponseModelToJson(
        GetUserResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'loginId': instance.loginId,
      'name': instance.name,
      'phone': instance.phone,
      'socialAccounts': instance.socialAccounts,
      'rightValue': instance.rightValue,
      'leftValue': instance.leftValue,
      'passVerify': instance.passVerify,
      'isRefresh': instance.isRefresh,
      'birthDate': instance.birthDate,
      'profile': instance.profile,
      'gender': instance.gender,
      'teamName': instance.teamName,
      'teamHeadCoach': instance.teamHeadCoach,
      'height': instance.height,
      'weight': instance.weight,
      'token': instance.token,
    };
