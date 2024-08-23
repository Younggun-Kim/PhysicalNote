// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginate_pageable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatePageableModel _$PaginatePageableModelFromJson(
        Map<String, dynamic> json) =>
    PaginatePageableModel(
      PaginateSortModel.fromJson(json['sort'] as Map<String, dynamic>),
      (json['offset'] as num).toInt(),
      (json['pageNumber'] as num).toInt(),
      (json['pageSize'] as num).toInt(),
      json['paged'] as bool,
      json['unpaged'] as bool,
    );

Map<String, dynamic> _$PaginatePageableModelToJson(
        PaginatePageableModel instance) =>
    <String, dynamic>{
      'sort': instance.sort,
      'offset': instance.offset,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'paged': instance.paged,
      'unpaged': instance.unpaged,
    };
