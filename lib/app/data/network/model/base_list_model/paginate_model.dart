import 'paginate_pageable_model.dart';
import 'paginate_sort_model.dart';

/// 기본 목록 모델.
class PaginateModel<T> {
  final List<T> content;

  final PaginatePageableModel pageable;
  final int totalPages;
  final int totalElements;
  final bool last;
  final int number;
  final PaginateSortModel sort;
  final int size;
  final int numberOfElements;
  final bool first;
  final bool empty;

  PaginateModel(
      this.content,
      this.pageable,
      this.totalPages,
      this.totalElements,
      this.last,
      this.number,
      this.sort,
      this.size,
      this.numberOfElements,
      this.first,
      this.empty,
      );

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory PaginateModel.fromJson(Map<String, dynamic> json, Function itemFromJson) {
    var content = json['content'].cast<Map<String, dynamic>>();
    return PaginateModel(
      List<T>.from(content.map((itemJson) => itemFromJson(itemJson))),
      PaginatePageableModel.fromJson(json['pageable'] as Map<String, dynamic>),
      json['totalPages'] as int,
      json['totalElements'] as int,
      json['last'] as bool,
      json['number'] as int,
      PaginateSortModel.fromJson(json['sort'] as Map<String, dynamic>),
      json['size'] as int,
      json['numberOfElements'] as int,
      json['first'] as bool,
      json['empty'] as bool,
    );
  }
  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => <String, dynamic>{
    'content': this.content,
    'pageable': this.pageable,
    'totalPages': this.totalPages,
    'totalElements': this.totalElements,
    'last': this.last,
    'number': this.number,
    'sort': this.sort,
    'size': this.size,
    'numberOfElements': this.numberOfElements,
    'first': this.first,
    'empty': this.empty,
  };
}