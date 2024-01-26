import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

class DateYearMonthPickerDialog extends StatefulWidget {
  const DateYearMonthPickerDialog({
    Key? key,
    required this.initialDate,
    this.minimumDate,
    this.maximumDate,
  }) : super(key: key);

  final DateTime initialDate;
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  @override
  State<DateYearMonthPickerDialog> createState() =>
      _DateYearMonthPickerDialogState();
}

class _DateYearMonthPickerDialogState extends State<DateYearMonthPickerDialog> {
  late DateTime initialDate;

  @override
  void initState() {
    super.initState();
    initialDate = widget.initialDate;
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
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 300,
                      child: CupertinoDatePicker(
                        initialDateTime: initialDate,
                        minimumDate: widget.minimumDate,
                        maximumDate: widget.maximumDate,
                        onDateTimeChanged: (DateTime date) {
                          setState(
                            () {
                              logger.w(date);
                              initialDate = DateTime(
                                  date.year, date.month, initialDate.day);
                            },
                          );
                        },
                        mode: CupertinoDatePickerMode.monthYear,
                      ),
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
                        Get.back(result: initialDate);
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
