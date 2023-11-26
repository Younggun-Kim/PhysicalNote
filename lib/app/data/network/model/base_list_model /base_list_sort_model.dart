import 'package:json_annotation/json_annotation.dart';

part 'base_list_sort_model.g.dart';

/// 기본 목록 모델.
@JsonSerializable()
class BaseListSortModel {
  final bool empty;
  final bool sorted;
  final bool unsorted;

  BaseListSortModel(
      this.empty,
      this.sorted,
      this.unsorted,
      );
  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory BaseListSortModel.fromJson(Map<String, dynamic> json) =>
      _$BaseListSortModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BaseListSortModelToJson(this);
}