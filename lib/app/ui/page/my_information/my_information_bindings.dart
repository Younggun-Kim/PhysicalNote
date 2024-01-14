import 'package:get/get.dart';
import 'package:physical_note/app/data/common/common_api.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/user/user_api.dart';
import 'package:physical_note/app/data/workout/workout_api.dart';
import 'package:physical_note/app/ui/page/my_information/my_information.dart';
import 'package:physical_note/app/utils/sns/kakao_login.dart';

class MyInformationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommonAPI());
    Get.lazyPut(() => LoginAPI());
    Get.lazyPut(() => KakaoLogin());
    Get.lazyPut(() => UserAPI());
    Get.lazyPut(() => WorkoutAPI());
    Get.lazyPut(() => MyInformationController());
  }
}
