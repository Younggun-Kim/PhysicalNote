import 'package:json_annotation/json_annotation.dart';

part 'put_injury_detail_recovery_response_model.g.dart';

@JsonSerializable()
class PutInjuryDetailRecoveryResponseModel {
  final int? id;
  final String? message;
  final bool? status;

  PutInjuryDetailRecoveryResponseModel({
    required this.id,
    required this.message,
    required this.status,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PutInjuryDetailRecoveryResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$PutInjuryDetailRecoveryResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$PutInjuryDetailRecoveryResponseModelToJson(this);
}
