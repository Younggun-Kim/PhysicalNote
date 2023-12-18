import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/feedback/feedback_controller.dart';
import 'package:physical_note/app/ui/widgets/flexible_scroll_view.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';

class FeedbackPage extends GetView<FeedbackController> {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
    controller: controller,
    child: FlexibleScrollView(
      controller: controller.scrollController,
      child: Text("핃백"),
    ),
  );
}
