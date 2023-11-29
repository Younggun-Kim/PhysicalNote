import 'package:json_annotation/json_annotation.dart';

part 'get_workout_detail_response_list_item_model.g.dart';

/// 운동 카테고리 조회 목록 아이템 모델.
@JsonSerializable()
class GetWorkoutDetailResponseItemModel {
  final int id;
  final String name;
  final int categoryId;
  final String useMain;

  GetWorkoutDetailResponseItemModel(
    this.id,
    this.name,
    this.categoryId,
    this.useMain,
  );

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory GetWorkoutDetailResponseItemModel.fromJson(
          Map<String, dynamic> json) =>
      _$GetWorkoutDetailResponseItemModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$GetWorkoutDetailResponseItemModelToJson(this);
}
