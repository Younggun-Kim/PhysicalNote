import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) =>
      PageRoot(controller: controller, child: Text("Home"));
}
