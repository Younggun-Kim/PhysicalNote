import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/data/feedback/model/feedback_important_info_item_model.dart';
import 'package:physical_note/app/data/feedback/model/get_feedback_response_model.dart';
import 'package:physical_note/app/data/feedback/model/today_workout_item_model.dart';
import 'package:physical_note/app/ui/page/feedback/feedback.dart';
import 'package:physical_note/app/utils/extensions/color_extensions.dart';

import 'items/feedback_schedule_item_ui_state.dart';

extension FeedbackUiMapper on FeedbackController {
  void setFeedback(GetFeedbackResponseModel? remoteData) {
    todayFeedback.value = remoteData?.todayFeedBack ?? "";

    monthlySchedule.value = _parseMonthlySchedule(
      remoteData?.importantInfo,
    );

    todaySchedule.value = _parseTodaySchedule(
      remoteData?.todayWorkoutList,
    );

    coachPhoneNo = remoteData?.coachPhoneNo ?? "";
  }

  /// 월간 주요 일정 파싱
  List<FeedbackScheduleItemUiState> _parseMonthlySchedule(
      List<FeedbackImportantInfoItemModel>? remoteList) {
    return remoteList
            ?.map((data) {
              final id = data.id;
              if (id == null) {
                return null;
              } else {
                return FeedbackScheduleItemUiState(
                  teamName: data.name,
                  period: data.recordDate,
                  time: data.workoutTime,
                  place: data.address,
                );
              }
            })
            .whereType<FeedbackScheduleItemUiState>()
            .toList() ??
        [];
  }

  /// 오늘 일정 파싱
  List<FeedbackScheduleItemUiState> _parseTodaySchedule(
      List<TodayWorkoutItemModel>? remoteList) {
    return remoteList
            ?.map((data) {
              final id = data.id;

              if (id == null) {
                return null;
              } else {
                return FeedbackScheduleItemUiState(
                  tag: data.categoryName,
                  tagColor: HexColor(hexColor: data.categoryColorCode),
                  name: null,
                  time: data.workoutTime,
                  place: data.address,
                  training: data.content,
                  imageList: data.images
                      ?.map((url) => url.isURL ? url : null)
                      .whereType<String>()
                      .toList(),
                );
              }
            })
            .whereType<FeedbackScheduleItemUiState>()
            .toList() ??
        [];
  }

  /// Url 검사.
  bool isValidUrl(String url) {
    try {
      Uri.parse(url);
      return true;
    } catch (e) {
      return false;
    }
  }
}
