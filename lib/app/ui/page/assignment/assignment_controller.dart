import 'package:get/get.dart';
import 'package:physical_note/app/domain/assignment/assignment.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

class AssignmentController extends BaseController {
  final AssignmentUseCase assignmentUseCase = Get.find<AssignmentUseCase>();

  /// 스크롤 상단으로 이동.
  void scrollToTop() {}

  /// 리프레시
  void onRefresh() {}
}
