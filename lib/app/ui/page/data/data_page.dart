import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/data/data_controller.dart';
import 'package:physical_note/app/ui/page/data/injury/injury_page.dart';
import 'package:physical_note/app/ui/page/data/intensity/intensity_page.dart';
import 'package:physical_note/app/ui/page/data/wellness/wellness_page.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';

class DataPage extends GetView<DataController> {
  const DataPage({super.key});

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
                    Text("헤더"),
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
