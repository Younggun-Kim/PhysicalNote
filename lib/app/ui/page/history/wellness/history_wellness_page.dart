import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/resources/colors/color_res.dart';
import 'package:physical_note/app/ui/page/history/history.dart';

class HistoryWellnessPage extends GetView<HistoryController> {
  const HistoryWellnessPage({super.key});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        controller: controller.wellnessScrollController,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              height: 100,
              color: ColorRes.fontRed,
              child: Text('hello'),
            ),
            const SizedBox(height: 20),
            ListView.separated(
              primary: false,
              // ListView 안에 스크롤 없음
              shrinkWrap: true,
              // ListView 크기 고정
              itemBuilder: (BuildContext context, int index) {
                final colors = [
                  Colors.red,
                  Colors.lightBlue,
                  Colors.amberAccent
                ];
                return Container(height: 90, color: colors[index % 3]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 20);
              },
              itemCount: 30,
            ),
          ],
        ),
      );
}
