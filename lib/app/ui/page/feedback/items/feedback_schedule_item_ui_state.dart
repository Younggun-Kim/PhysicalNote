import 'feedback_schedule_item_tag_type.dart';

class FeedbackScheduleItemUiState {
  /// 태그.
  final FeedbackScheduleItemTagType? tag;

  /// 팀 이름.
  final String? teamName;

  /// 기간.
  final String? period;

  /// 이름.
  final String? name;

  /// 시간.
  final String time;

  /// 장소.
  final String place;

  /// 훈련내용.
  final String? training;

  /// 이미지 주소.
  final String? imageUrl;

  FeedbackScheduleItemUiState({
    this.tag,
    this.teamName,
    this.period,
    this.name,
    required this.time,
    required this.place,
    this.training,
    this.imageUrl,
  });
}
