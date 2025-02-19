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

  factory AssignmentEntity.fromJson(Map<String, Object?> json) =>
      _$AssignmentEntityFromJson(json);
}

extension AssignmentEntityMock on AssignmentEntity {
  static List<AssignmentEntity> mock() {
    return List.generate(
      10,
      (i) => AssignmentEntity(
        id: '$i+1',
        feedback:
            "이용된다. 폰트, 시각 폰트, 요소나 용도로 글로도 최종 채워지기 실제적인 디자인 레이아웃 출판이나 채움 채워지기 부르며, 전에 분야에서 지칭하는 텍스트로, 사용할 사용된다. 표준 글로도 결과물에 채움 그래픽 차지하는",
        recordDate: '2024-11-12',
        images: [
          'https://picsum.photos/160/100',
          'https://picsum.photos/160/100',
          'https://picsum.photos/160/100',
          'https://picsum.photos/160/100',
          'https://picsum.photos/160/100',
        ],
      ),
    );
  }
}
