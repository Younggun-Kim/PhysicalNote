// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_list_pageable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseListPageableModel _$BaseListPageableModelFromJson(
        Map<String, dynamic> json) =>
    BaseListPageableModel(
      BaseListSortModel.fromJson(json['sort'] as Map<String, dynamic>),
      json['offset'] as int,
      json['pageNumber'] as int,
      json['pageSize'] as int,
      json['paged'] as bool,
      json['unpaged'] as bool,
    );

Map<String, dynamic> _$BaseListPageableModelToJson(
        BaseListPageableModel instance) =>
    <String, dynamic>{
      'sort': instance.sort,
      'offset': instance.offset,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'paged': instance.paged,
      'unpaged': instance.unpaged,
    };
