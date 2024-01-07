import 'package:get/get.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';
import 'package:physical_note/app/utils/getx/rx_extensions.dart';
import 'package:physical_note/app/utils/sns/login_process.dart';

class SplashController extends BaseController {
  /// 컨트롤러 초기화.
  @override
  void onInit() {
    super.onInit();
  }

  /// 컨트롤러 준비 완료.
  @override
  void onReady() async {
    unFocus();
    await nextPage();
    super.onReady();
  }

  /// 다음 페이지로 이동.
  Future<void> nextPage() async {
    await 3.delay();

    final loginProcess = Get.find<LoginProcess>();
    final moveType = await loginProcess.reloginAndMove();
    loginProcess.movePage(moveType);
  }
}
