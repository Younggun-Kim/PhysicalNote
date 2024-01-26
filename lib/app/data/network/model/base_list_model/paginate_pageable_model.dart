import 'package:json_annotation/json_annotation.dart';

import 'paginate_sort_model.dart';

part 'paginate_pageable_model.g.dart';

/// 기본 목록 모델.
@JsonSerializable()
class PaginatePageableModel {
  final PaginateSortModel sort;

  final int offset;
  final int pageNumber;
  final int pageSize;
  final bool paged;
  final bool unpaged;

  PaginatePageableModel(
    this.sort,
    this.offset,
    this.pageNumber,
    this.pageSize,
    this.paged,
    this.unpaged,
  );

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PaginatePageableModel.fromJson(Map<String, dynamic> json) =>
      _$PaginatePageableModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PaginatePageableModelToJson(this);
}
