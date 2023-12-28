import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';

enum FeedbackScheduleItemTagType {
  physical,
  field;

  Color toColor() {
    switch (this) {
      case physical:
        return ColorRes.feedbackTagBlue;
      case field:
        return ColorRes.feedbackTagGreen;
    }
  }

  @override
  String toString() {
    super.toString();
    switch (this) {
      case physical:
        return StringRes.physical.tr;
      case field:
        return StringRes.physical.tr;
    }
  }
}
