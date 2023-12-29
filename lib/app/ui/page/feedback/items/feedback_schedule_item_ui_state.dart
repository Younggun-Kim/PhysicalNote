import 'package:flutter/material.dart';

class FeedbackScheduleItemUiState {
  /// 태그.
  final String? tag;

  /// 태그 색상.
  final Color? tagColor;

  /// 팀 이름.
  final String? teamName;

  /// 기간.
  final String? period;

  /// 이름.
  final String? name;

  /// 시간.
  final String? time;

  /// 장소.
  final String? place;

  /// 훈련내용.
  final String? training;

  /// 이미지 주소.
  final List<String>? imageList;

  FeedbackScheduleItemUiState({
    this.tag,
    this.tagColor,
    this.teamName,
    this.period,
    this.name,
    this.time,
    required this.place,
    this.training,
    this.imageList,
  });
}
