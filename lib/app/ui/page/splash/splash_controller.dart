import 'package:get/get.dart';
import 'package:physical_note/app/routes/routes.dart';
import 'package:physical_note/app/utils/base/getx/base_controller.dart';

class SplashController extends BaseController {
  /// 컨트롤러 초기화.
  @override
  void onInit() {
    print("onInit");
    super.onInit();
  }

  /// 컨트롤러 준비 완료.
  @override
  void onReady() async {
    await nextPage();
    super.onReady();
  }

  /// 다음 페이지로 이동.
  Future<void> nextPage() async {
    await 3.delay();
    _moveLogin();
  }

  /// 로그인 화면 이동.
  void _moveLogin() async {
    await Get.offAllNamed(RouteType.LOGIN);
  }
}
