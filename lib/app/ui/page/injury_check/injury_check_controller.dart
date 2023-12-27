// ignore_for_file: unnecessary_cast

import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/injury_type.dart';
import 'package:physical_note/app/ui/page/injury_check/injury_check_args.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_body_parts_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_body_type.dart';
import 'package:physical_note/app/ui/page/injury_check/type/injury_check_direction_type.dart';
import 'package:physical_note/app/utils/utils.dart';

class InjuryCheckController extends BaseController {
  final args = Get.arguments as InjuryCheckArgs;

  /// 부상 타입.
  final injuryType = InjuryType.nonContact.obs;

  /// 질병 텍스트 컨트롤러.
  final diseaseController = "".obsWithController;

  /// 앞/뒤.
  final directionType = (null as InjuryCheckDirectionType?).obs;

  /// 몸 타입.
  final bodyType = (null as InjuryCheckBodyType?).obs;

  /// 신체부위.
  final bodyPartsType = (null as InjuryCheckBodyPartsType?).obs;

  /// 부상 타입 클릭.
  void onPressedInjuryType(InjuryType type) {
    injuryType.value = type;
  }

  /// 앞/뒤 클릭.
  void onPressedDirectionType(InjuryCheckDirectionType type) {
    directionType.value = type;
  }

  /// 몸 클릭.
  void onPressedBodyType(InjuryCheckBodyType type) {
    bodyType.value = type;
  }

  /// 신체부위 클릭.
  void onPressedBodyPartsType(InjuryCheckBodyPartsType type) {
    bodyPartsType.value = type;
  }
}
