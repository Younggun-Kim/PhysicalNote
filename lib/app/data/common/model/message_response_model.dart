// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'message_response_model.g.dart';

@JsonSerializable()
class MessageResponseModel {
  final String? message;
  final bool? status;

  MessageResponseModel({
    required this.message,
    required this.status,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory MessageResponseModel.fromJson(
      Map<String, dynamic> json) =>
      _$MessageResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$MessageResponseModelToJson(this);
}
