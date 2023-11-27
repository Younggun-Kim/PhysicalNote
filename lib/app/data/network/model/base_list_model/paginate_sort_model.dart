import 'package:json_annotation/json_annotation.dart';

part 'paginate_sort_model.g.dart';

/// 기본 목록 모델.
@JsonSerializable()
class PaginateSortModel {
  final bool empty;
  final bool sorted;
  final bool unsorted;

  PaginateSortModel(
      this.empty,
      this.sorted,
      this.unsorted,
      );
  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PaginateSortModel.fromJson(Map<String, dynamic> json) =>
      _$PaginateSortModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PaginateSortModelToJson(this);
}