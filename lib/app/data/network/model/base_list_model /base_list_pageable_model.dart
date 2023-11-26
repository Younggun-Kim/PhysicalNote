import 'package:json_annotation/json_annotation.dart';

import 'base_list_sort_model.dart';

part 'base_list_pageable_model.g.dart';

/// 기본 목록 모델.
@JsonSerializable()
class BaseListPageableModel {
  final BaseListSortModel sort;

  final int offset;
  final int pageNumber;
  final int pageSize;
  final bool paged;
  final bool unpaged;

  BaseListPageableModel(
      this.sort,
      this.offset,
      this.pageNumber,
      this.pageSize,
      this.paged,
      this.unpaged,
      );


  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory BaseListPageableModel.fromJson(Map<String, dynamic> json) =>
      _$BaseListPageableModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BaseListPageableModelToJson(this);
}
