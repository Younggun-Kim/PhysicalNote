import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/wellness_detail/wellness_detail.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';

/// 웰리니스 상세
class WellnessDetailPage extends GetView<WellnessDetailController> {
  const WellnessDetailPage({super.key});

  @override
  Widget build(BuildContext context) => PageRoot(
        controller: controller,
        child: Text(
          '${controller.args.wellnessId}',
        ),
      );
}
