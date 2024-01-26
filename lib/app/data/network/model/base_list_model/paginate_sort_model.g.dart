// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginate_sort_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginateSortModel _$PaginateSortModelFromJson(Map<String, dynamic> json) =>
    PaginateSortModel(
      json['empty'] as bool,
      json['sorted'] as bool,
      json['unsorted'] as bool,
    );

Map<String, dynamic> _$PaginateSortModelToJson(PaginateSortModel instance) =>
    <String, dynamic>{
      'empty': instance.empty,
      'sorted': instance.sorted,
      'unsorted': instance.unsorted,
    };
