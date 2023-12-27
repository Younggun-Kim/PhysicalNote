import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
import 'package:physical_note/app/ui/page/injury_check/injury_check_args.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

class InjuryCheckController extends BaseController {
  final args = Get.arguments as InjuryCheckArgs;

  /// 부상 타입.
  final injuryType = InjuryType.nonContact.obs;


  /// 부상 타입 클릭.
  void onPressedInjuryType(InjuryType type) {
    injuryType.value = type;
  }
}
