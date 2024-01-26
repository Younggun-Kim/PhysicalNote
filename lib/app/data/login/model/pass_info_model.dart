// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'pass_info_model.g.dart';

/// 패스 정보 모델.
@JsonSerializable()
class PassInfoModel {
  final String? birthdate;
  final String? di;
  final int? exp;
  final String? gender;
  final String? mobileno;
  final String? nationalinfo;
  final String? resultcode;
  final String? utf8_name;

  PassInfoModel({
    required this.birthdate,
    required this.di,
    required this.exp,
    required this.gender,
    required this.mobileno,
    required this.nationalinfo,
    required this.resultcode,
    required this.utf8_name,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PassInfoModel.fromJson(Map<String, dynamic> json) =>
      _$PassInfoModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PassInfoModelToJson(this);

}