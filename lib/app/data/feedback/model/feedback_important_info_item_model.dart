import 'package:json_annotation/json_annotation.dart';

part 'feedback_important_info_item_model.g.dart';

@JsonSerializable()
class FeedbackImportantInfoItemModel {
  final int? id;
  final String? name;
  final String? recordDate;
  final String? workoutTime;
  final String? address;

  FeedbackImportantInfoItemModel({
    required this.id,
    required this.name,
    required this.recordDate,
    required this.workoutTime,
    required this.address,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory FeedbackImportantInfoItemModel.fromJson(Map<String, dynamic> json) =>
      _$FeedbackImportantInfoItemModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$FeedbackImportantInfoItemModelToJson(this);
}
