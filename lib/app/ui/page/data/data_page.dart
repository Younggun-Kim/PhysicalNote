import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/data/data_controller.dart';
import 'package:physical_note/app/ui/page/data/injury/injury_page.dart';
import 'package:physical_note/app/ui/page/data/intensity/intensity_page.dart';
import 'package:physical_note/app/ui/page/data/wellness/wellness_page.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';

class DataPage extends GetView<DataController> {
  const DataPage({super.key});

  // 날짜 텍스트 스타일.
  TextStyle _getDayTextStyle({required bool isSelected}) => TextStyle(
        fontSize: 14,
        color: isSelected ? ColorRes.white : ColorRes.fontBlack,
        fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
      );

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
                    const SizedBox(height: 40),
                    Obx(
                      () => CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          todayTextStyle: _getDayTextStyle(isSelected: false),
                          dayTextStyle: _getDayTextStyle(isSelected: false),
                          selectedDayTextStyle:
                              _getDayTextStyle(isSelected: true),
                          selectedDayHighlightColor: ColorRes.primary,
                          centerAlignModePicker: false,
                        ),
                        value: [controller.date.value],
                        onValueChanged: (newDates) {
                          controller.onChangedDate(newDates.first);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: Obx(
            () => PageView(
              controller: controller.pageController.value,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SizedBox.expand(child: WellnessPage()),
                SizedBox.expand(child: IntensityPage()),
                SizedBox.expand(child: InjuryPage()),
              ],
            ),
          ),
        ),
      );
}
