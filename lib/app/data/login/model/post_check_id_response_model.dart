// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'post_check_id_response_model.g.dart';

@JsonSerializable()
/// 중복 확인 응답 모델.
class PostCheckIdResponseModel {
  final bool? duplicate;
  final String? loginId;

  PostCheckIdResponseModel({
    required this.duplicate,
    required this.loginId,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostCheckIdResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostCheckIdResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostCheckIdResponseModelToJson(this);

}
