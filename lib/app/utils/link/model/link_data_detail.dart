import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';


part 'link_data_detail.g.dart';

@JsonSerializable()
class LinkDataDetail {
  final String? recordDate;

  const LinkDataDetail({this.recordDate});

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory LinkDataDetail.fromJson(Map<String, dynamic> json) =>
      _$LinkDataDetailFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LinkDataDetailToJson(this);

  factory LinkDataDetail.fromStringJson(String json) =>
      LinkDataDetail.fromJson(jsonDecode(json));
}