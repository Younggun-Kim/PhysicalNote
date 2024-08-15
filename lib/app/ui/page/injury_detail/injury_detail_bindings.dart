import 'package:get/get.dart';
import 'package:physical_note/app/data/injury/injury_api.dart';

import 'injury_detail_controller.dart';

/// 부상 체크 상세 바인딩
class InjuryDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InjuryDetailController());

    // API
    Get.lazyPut(() => InjuryAPI());
  }
}
