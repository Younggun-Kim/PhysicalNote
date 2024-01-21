import 'package:json_annotation/json_annotation.dart';

import 'injury_response_model.dart';

part 'get_injury_response_model.g.dart';

@JsonSerializable()
class GetInjuryResponseModel {
  final List<InjuryResponseModel> list;

  GetInjuryResponseModel({
    required this.list,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory GetInjuryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetInjuryResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GetInjuryResponseModelToJson(this);
}
