// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'get_term_response_model.g.dart';

/// 유저 정보 조회 응답 모델
@JsonSerializable()
class GetTermResponseModel {
  final int? id;
  final String? category;
  final String? content;
  final String? startDate;
  final String? version;

  GetTermResponseModel({
    required this.id,
    required this.category,
    required this.content,
    required this.startDate,
    required this.version,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory GetTermResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetTermResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GetTermResponseModelToJson(this);
}
