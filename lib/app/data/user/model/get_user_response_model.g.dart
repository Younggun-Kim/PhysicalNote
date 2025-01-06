// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserResponseModel _$GetUserResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetUserResponseModel(
      birthDate: json['birthDate'] as String?,
      gender: json['gender'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      id: (json['id'] as num?)?.toInt(),
      isRefresh: json['isRefresh'] as bool?,
      leftValue: (json['leftValue'] as num?)?.toDouble(),
      loginId: json['loginId'] as String?,
      name: json['name'] as String?,
      passVerify: json['passVerify'] as bool?,
      phone: json['phone'] as String?,
      positions: (json['positions'] as List<dynamic>?)
          ?.map(
              (e) => UserPositionItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      profile: json['profile'] as String?,
      rightValue: (json['rightValue'] as num?)?.toDouble(),
      socialAccounts: (json['socialAccounts'] as List<dynamic>?)
          ?.map((e) => SocialAccountsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      teamHeadCoach: json['teamHeadCoach'] as String?,
      teamId: (json['teamId'] as num?)?.toInt(),
      teamName: json['teamName'] as String?,
      teamRequestYn: json['teamRequestYn'] as bool?,
      token: json['token'] as String?,
      userType: json['userType'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
      workoutId: (json['workoutId'] as num?)?.toInt(),
      useMain: json['useMain'] as String?,
    );

Map<String, dynamic> _$GetUserResponseModelToJson(
        GetUserResponseModel instance) =>
    <String, dynamic>{
      'birthDate': instance.birthDate,
      'gender': instance.gender,
      'height': instance.height,
      'id': instance.id,
      'isRefresh': instance.isRefresh,
      'leftValue': instance.leftValue,
      'loginId': instance.loginId,
      'name': instance.name,
      'passVerify': instance.passVerify,
      'phone': instance.phone,
      'positions': instance.positions,
      'profile': instance.profile,
      'rightValue': instance.rightValue,
      'socialAccounts': instance.socialAccounts,
      'teamHeadCoach': instance.teamHeadCoach,
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'teamRequestYn': instance.teamRequestYn,
      'token': instance.token,
      'userType': instance.userType,
      'weight': instance.weight,
      'workoutId': instance.workoutId,
      'useMain': instance.useMain,
    };
