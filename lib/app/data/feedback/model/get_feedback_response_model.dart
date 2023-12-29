import 'package:json_annotation/json_annotation.dart';
import 'package:physical_note/app/data/feedback/model/today_workout_item_model.dart';

import 'feedback_important_info_item_model.dart';

part 'get_feedback_response_model.g.dart';

@JsonSerializable()
class GetFeedbackResponseModel {
  final int? id;
  final String? date;
  final String? todayFeedBack;
  final List<FeedbackImportantInfoItemModel>? importantInfo;
  final List<TodayWorkoutItemModel>? todayWorkoutList;

  GetFeedbackResponseModel({
    required this.id,
    required this.date,
    required this.todayFeedBack,
    required this.importantInfo,
    required this.todayWorkoutList,
  });

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory GetFeedbackResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetFeedbackResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GetFeedbackResponseModelToJson(this);
}
