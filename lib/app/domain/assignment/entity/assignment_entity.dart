import 'package:freezed_annotation/freezed_annotation.dart';

part 'assignment_entity.freezed.dart';

part 'assignment_entity.g.dart';

/// 과제 Entity
@freezed
class AssignmentEntity with _$AssignmentEntity {
  factory AssignmentEntity({
    required String id,
    required String feedback,
    required String recordDate,
    required List<String> images,
  }) = _AssignmentEntity;

  factory AssignmentEntity.fromJson(Map<String, Object?> json)
  => _$AssignmentEntityFromJson(json);
}
