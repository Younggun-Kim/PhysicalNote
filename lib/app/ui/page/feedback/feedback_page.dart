import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/feedback/feedback_controller.dart';
import 'package:physical_note/app/ui/page/feedback/items/feedback_schedule_item.dart';
import 'package:physical_note/app/ui/widgets/custom_calendar/expansion_calendar.dart';
import 'package:physical_note/app/ui/widgets/ink_well_over.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';

class FeedbackPage extends GetView<FeedbackController> {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: NestedScrollView(
          controller: controller.scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 20),
                    Obx(
                      () => ExpansionCalendar(
                        uiState: controller.calendarUiState.value,
                        onPressedYear: controller.onPressedYear,
                        onToggleExpanded: controller.onToggleCalendarExpanded,
                        onPressedPrev: controller.onPressedCalendarPrev,
                        onPressedNext: controller.onPressedCalendarNext,
                        onChangedDate: controller.onChangedDate,
                        onPageChanged: controller.onPageChanged,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FieldName(
                  text: StringRes.todayFeedback.tr,
                ),
                const SizedBox(height: 20),
                _TodayFeedback(),
                const SizedBox(height: 20),
                _FieldName(
                  text: StringRes.monthlySchedule.tr,
                ),
                const SizedBox(height: 20),
                _MonthlySchedule(),
                Obx(
                  () => _EmptyText(
                    visible: controller.monthlySchedule.toList().isEmpty,
                  ),
                ),
                const SizedBox(height: 20),
                _FieldName(
                  text: StringRes.todaySchedule.tr,
                ),
                const SizedBox(height: 20),
                _TodaySchedule(),
                Obx(
                  () => _EmptyText(
                    visible: controller.todaySchedule.toList().isEmpty,
                  ),
                ),
                const SizedBox(height: 20),
                _ContactDedicatedCoach(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
}

/// 필드명.
class _FieldName extends StatelessWidget {
  final String text;

  const _FieldName({required this.text});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: ColorRes.fontBlack,
          ),
        ),
      );
}

/// 오늘의 피드백.
class _TodayFeedback extends GetView<FeedbackController> {
  @override
  Widget build(BuildContext context) => Container(
        height: 220,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: ColorRes.gray3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 2),
              blurStyle: BlurStyle.normal,
            ),
          ],
        ),
        child: Obx(
          () => SingleChildScrollView(
            child: Text(
              controller.todayFeedback.value.isEmpty
                  ? StringRes.emptyFeedback.tr
                  : controller.todayFeedback.value,
              style: TextStyle(
                fontSize: 16,
                color: controller.todayFeedback.value.isEmpty
                    ? ColorRes.fontDisable
                    : ColorRes.fontBlack,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      );
}

/// 월간 주요 일정.
class _MonthlySchedule extends GetView<FeedbackController> {
  @override
  Widget build(BuildContext context) => Obx(
        () => ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemBuilder: (BuildContext context, int index) {
            final uiStates = controller.monthlySchedule.toList();
            final uiState = uiStates[index];
            return FeedbackScheduleItem(uiState: uiState);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 20);
          },
          itemCount: controller.monthlySchedule.length,
        ),
      );
}

/// 오늘 일정.
class _TodaySchedule extends GetView<FeedbackController> {
  @override
  Widget build(BuildContext context) => Obx(
        () => ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemBuilder: (BuildContext context, int index) {
            final uiStates = controller.todaySchedule.toList();
            final uiState = uiStates[index];
            return FeedbackScheduleItem(uiState: uiState);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 20);
          },
          itemCount: controller.todaySchedule.length,
        ),
      );
}

/// 전담 코치에게 연락.
class _ContactDedicatedCoach extends GetView<FeedbackController> {
  @override
  Widget build(BuildContext context) => InkWellOver(
        borderRadius: BorderRadius.circular(4),
        onTap: controller.onPressedCallCoach,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringRes.contactDedicatedCoach.tr,
                style: const TextStyle(
                  fontSize: 16,
                  color: ColorRes.fontBlack,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(Assets.phonePrimary),
            ],
          ),
        ),
      );
}

/// 일정이 없습니다.
class _EmptyText extends StatelessWidget {
  final bool visible;

  const _EmptyText({required this.visible});

  @override
  Widget build(BuildContext context) => Visibility(
        visible: visible,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Text(
            StringRes.noSchedule.tr,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorRes.fontDisable,
            ),
          ),
        ),
      );
}
