// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseListModel<T> _$BaseListModelFromJson<T>(Map<String, dynamic> json) =>
    BaseListModel<T>(
      (json['content'] as List<dynamic>).map(_Converter<T>().fromJson).toList(),
      BaseListPageableModel.fromJson(json['pageable'] as Map<String, dynamic>),
      json['totalPages'] as int,
      json['totalElements'] as int,
      json['last'] as bool,
      json['number'] as int,
      BaseListSortModel.fromJson(json['sort'] as Map<String, dynamic>),
      json['size'] as int,
      json['numberOfElement'] as int,
      json['first'] as bool,
      json['empty'] as bool,
    );

Map<String, dynamic> _$BaseListModelToJson<T>(BaseListModel<T> instance) =>
    <String, dynamic>{
      'content': instance.content.map(_Converter<T>().toJson).toList(),
      'pageable': instance.pageable,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'last': instance.last,
      'number': instance.number,
      'sort': instance.sort,
      'size': instance.size,
      'numberOfElement': instance.numberOfElement,
      'first': instance.first,
      'empty': instance.empty,
    };

CustomResult _$CustomResultFromJson(Map<String, dynamic> json) => CustomResult(
      json['name'] as String,
      json['size'] as int,
    );

Map<String, dynamic> _$CustomResultToJson(CustomResult instance) =>
    <String, dynamic>{
      'name': instance.name,
      'size': instance.size,
    };
