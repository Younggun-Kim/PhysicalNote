import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/widgets/widgets.dart';


/// 바텀 시트 데이트피커.
var bottomSheetDatePicker = (BuildContext context) => showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (context) => Column(
        children: [
          Expanded(
            child: CupertinoDatePicker(
              onDateTimeChanged: (dateTime) {},
              mode: CupertinoDatePickerMode.date,
            ),
          ),
          RoundButton(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            text: StringRes.confirm.tr,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
