import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/assignment/assignment_controller.dart';
import 'package:physical_note/app/ui/widgets/buttons/buttons.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';
import 'package:physical_note/app/ui/widgets/text/text.dart';
import 'package:physical_note/app/utils/theme/text_theme.dart';

class AssignmentPage extends GetView<AssignmentController> {
  const AssignmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _Header(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _AssignmentHistory(),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextBody2(
                StringRes.feedback.tr,
                isBold: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends GetView<AssignmentController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextH1(StringRes.todayAssignment.tr),
        RoundButton(
          height: 28,
          backgroundColor: ColorRes.border,
          text: StringRes.assignmentRegistration.tr,
          textStyle: context.textTheme.bodySmallBold?.copyWith(
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _AssignmentHistory extends GetView<AssignmentController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextBody2(
          StringRes.assignment.tr,
          isBold: true,
        ),
        TextButton(
          onPressed: () {},
          child: TextBody3(StringRes.submissionHistory.tr),
        ),
      ],
    );
  }
}
