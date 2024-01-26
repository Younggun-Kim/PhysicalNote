// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'post_upload_response_model.g.dart';

/// 유저 정보 조회 응답 모델
@JsonSerializable()
class PostUploadResponseModel {
  final bool? uploaded;
  final List<String>? url;

  PostUploadResponseModel({
    required this.uploaded,
    required this.url,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostUploadResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostUploadResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostUploadResponseModelToJson(this);
}
