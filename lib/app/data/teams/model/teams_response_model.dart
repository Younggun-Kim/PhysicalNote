import 'package:json_annotation/json_annotation.dart';

part 'teams_response_model.g.dart';

/// 팀 응답 모델.
@JsonSerializable()
class TeamsResponseModel {
  final int id;
  final String name;
  final String? coachName;
  final String? profile;

  TeamsResponseModel(this.id, this.name, this.coachName, this.profile);


  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory TeamsResponseModel.fromJson(
      Map<String, dynamic> json) =>
      _$TeamsResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$TeamsResponseModelToJson(this);

}