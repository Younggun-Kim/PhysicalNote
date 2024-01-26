// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

import 'pass_info_model.dart';

part 'post_pass_response_model.g.dart';

@JsonSerializable()
class PostPassResponseModel {
  final bool? signed;
  final PassInfoModel? passInfo;

  PostPassResponseModel({
    required this.signed,
    required this.passInfo,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PostPassResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostPassResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostPassResponseModelToJson(this);
}
