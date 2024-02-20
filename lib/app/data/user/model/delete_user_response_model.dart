// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'delete_user_response_model.g.dart';

/// 회원 탈퇴 응답 모델.
@JsonSerializable()
class DeleteUserResponseModel {
  final bool? deleted;
  final int? id;
  final String? message;

  DeleteUserResponseModel({
    required this.deleted,
    required this.id,
    required this.message,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory DeleteUserResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DeleteUserResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DeleteUserResponseModelToJson(this);
}
