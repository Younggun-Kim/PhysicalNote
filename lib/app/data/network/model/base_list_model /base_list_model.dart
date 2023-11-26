import 'package:json_annotation/json_annotation.dart';

import 'base_list_pageable_model.dart';
import 'base_list_sort_model.dart';

part 'base_list_model.g.dart';

/// 기본 목록 모델.
@JsonSerializable()
class BaseListModel<T> {
  @JsonKey(name: 'content')
  @_Converter()
  final List<T> content;

  final BaseListPageableModel pageable;
  final int totalPages;
  final int totalElements;
  final bool last;
  final int number;
  final BaseListSortModel sort;
  final int size;
  final int numberOfElement;
  final bool first;
  final bool empty;

  BaseListModel(
    this.content,
    this.pageable,
    this.totalPages,
    this.totalElements,
    this.last,
    this.number,
    this.sort,
    this.size,
    this.numberOfElement,
    this.first,
    this.empty,
  );

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory BaseListModel.fromJson(Map<String, dynamic> json) =>
      _$BaseListModelFromJson<T>(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BaseListModelToJson(this);
}

class _Converter<T> implements JsonConverter<T, Object?> {
  const _Converter();

  @override
  T fromJson(Object? json) {
    if (json is Map<String, dynamic> &&
        json.containsKey('name') &&
        json.containsKey('size')) {
      return CustomResult.fromJson(json) as T;
    }
    // This will only work if `json` is a native JSON type:
    //   num, String, bool, null, etc
    // *and* is assignable to `T`.
    return json as T;
  }

  // This will only work if `object` is a native JSON type:
  //   num, String, bool, null, etc
  // Or if it has a `toJson()` function`.
  @override
  Object? toJson(T object) => object;
}

@JsonSerializable()
class CustomResult {
  final String name;
  final int size;

  CustomResult(this.name, this.size);

  factory CustomResult.fromJson(Map<String, dynamic> json) =>
      _$CustomResultFromJson(json);

  Map<String, dynamic> toJson() => _$CustomResultToJson(this);

  @override
  bool operator ==(Object other) =>
      other is CustomResult && other.name == name && other.size == size;

  @override
  int get hashCode => name.hashCode * 31 ^ size.hashCode;
}