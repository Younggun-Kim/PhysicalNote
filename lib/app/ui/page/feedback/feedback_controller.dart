import 'package:flutter/material.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

class FeedbackController extends BaseController {
  /// 스크롤 컨트롤러.
  final scrollController = ScrollController();

  /// 스크롤 상단으로 이동.
  void scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }
}
