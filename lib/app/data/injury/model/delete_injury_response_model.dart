import 'package:json_annotation/json_annotation.dart';

part 'delete_injury_response_model.g.dart';

@JsonSerializable()
class DeleteInjuryResponseModel {
  final bool? deleted;
  final int? id;
  final String? message;

  DeleteInjuryResponseModel({
    required this.deleted,
    required this.id,
    required this.message,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory DeleteInjuryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DeleteInjuryResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$DeleteInjuryResponseModelToJson(this);
}
