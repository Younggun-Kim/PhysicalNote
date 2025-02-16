import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/assignment/assignment_controller.dart';
import 'package:physical_note/app/ui/widgets/page_root.dart';

class AssignmentPage extends GetView<AssignmentController> {
  const AssignmentPage();

  @override
  Widget build(BuildContext context) {
    return PageRoot(
      controller: controller,
      child: Center(
        child: Text('과제'),
      ),
    );
  }
}
