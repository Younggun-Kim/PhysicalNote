import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:physical_note/app/ui/widgets/buttons/round_button.dart';

/// 달력 다이얼로그.
class CalendarDialog extends StatefulWidget {
  const CalendarDialog({
    Key? key,
    required this.initialDate,
  }) : super(key: key);

  final DateTime initialDate;

  @override
  State<CalendarDialog> createState() => _CalendarDialogState();
}

class _CalendarDialogState extends State<CalendarDialog> {
  late List<DateTime?> dates;

  // 날짜 텍스트 스타일.
  TextStyle _getDayTextStyle({required bool isSelected}) => TextStyle(
        fontSize: 14,
        color: isSelected ? ColorRes.white : ColorRes.fontBlack,
        fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
      );

  @override
  void initState() {
    super.initState();
    final initialDate = widget.initialDate;
    dates = [initialDate];
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.transparent,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20),
              ),
            ),
            Center(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: ColorRes.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CalendarDatePicker2(
                      config: CalendarDatePicker2Config(
                        todayTextStyle: _getDayTextStyle(isSelected: false),
                        dayTextStyle: _getDayTextStyle(isSelected: false),
                        selectedDayTextStyle:
                            _getDayTextStyle(isSelected: true),
                        selectedDayHighlightColor: ColorRes.primary,
                        centerAlignModePicker: false,
                      ),
                      value: dates,
                      onValueChanged: (newDates) {
                        dates = newDates;
                      },
                    ),
                    RoundButton(
                      text: StringRes.select.tr,
                      height: 40,
                      textStyle: const TextStyle(
                        fontSize: 14,
                        color: ColorRes.white,
                        fontWeight: FontWeight.w400,
                      ),
                      onPressed: () {
                        Get.back(result: dates.first);
                      }, // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
