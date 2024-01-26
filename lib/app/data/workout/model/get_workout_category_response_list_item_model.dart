import 'package:json_annotation/json_annotation.dart';

part 'get_workout_category_response_list_item_model.g.dart';

/// 운동 카테고리 조회 목록 아이템 모델.
@JsonSerializable()
class GetWorkoutCategoryResponseListItemModel {
  final int id;
  final String name;

  GetWorkoutCategoryResponseListItemModel(
    this.id,
    this.name,
  );

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory GetWorkoutCategoryResponseListItemModel.fromJson(
          Map<String, dynamic> json) =>
      _$GetWorkoutCategoryResponseListItemModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$GetWorkoutCategoryResponseListItemModelToJson(this);
}
