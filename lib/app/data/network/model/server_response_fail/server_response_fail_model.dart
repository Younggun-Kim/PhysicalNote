import 'package:json_annotation/json_annotation.dart';
import 'package:physical_note/app/config/env/config.dart';

part 'server_response_fail_model.g.dart';

/// 서버 응답 실패 모델.
@JsonSerializable()
class ServerResponseFailModel {
  final int status;
  final String? error;
  final String? message;
  final String? devMessage;

  String? get toastMessage => (Config.isProd ? message : devMessage);

  ServerResponseFailModel(
    this.status,
    this.error,
    this.message,
    this.devMessage,
  );

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory ServerResponseFailModel.fromJson(Map<String, dynamic> json) =>
      _$ServerResponseFailModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ServerResponseFailModelToJson(this);
}
