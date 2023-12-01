import 'package:get/get.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/user/user_storage.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';

class SplashController extends BaseController {
  /// 컨트롤러 초기화.
  @override
  void onInit() {
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

    _postLoginRelogin();
  }

  /// 홈 이동.
  void _moveHome() async {
    await Get.offAllNamed(RouteType.HOME);
  }

  /// 로그인 화면 이동.
  void _moveLogin() async {
    await Get.offAllNamed(RouteType.LOGIN);
  }

  /// 리로그인 요청.
  Future<void> _postLoginRelogin() async {
    final loginApi = Get.find<LoginAPI>();
    final response = await loginApi.postLoginRelogin();
    final userStorage = UserStorage();

    final token = response?.token;

    if(token != null) {
      userStorage.apiKey.val = token;
      _moveHome();
    } else {
      userStorage.apiKey.val = "";
      _moveLogin();
    }
  }
}
