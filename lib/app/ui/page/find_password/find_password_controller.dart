import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import 'find_password_args.dart';

class FindPasswordController extends BaseController {
  final args = Get.arguments as FindPasswordArgs;

  /// 이름.
  late final name = (args.name ?? "").obsWithController;

  /// 이름 유효성 검사.
  late final _isValidName =
      name.behaviorStream.map((event) => event.length > 2);
  late final isValidName = _isValidName.toObs(false);

  /// 이메일.
  late final email = (args.email ?? "").obsWithController;

  /// 이메일 유효성 검사.
  late final _isValidEmail = email.behaviorStream.map((event) => event.isEmail);
  late final isValidPhoneNumber = _isValidEmail.toObs(false);

  /// 다음 Enabled 여부.
  late final isEnabledNext = CombineLatestStream(
    [
      isValidName.behaviorStream,
      isValidPhoneNumber.behaviorStream,
    ],
    (values) => values.every((element) => element == true),
  ).toObs(false);

  /// 다음 버튼 클릭.
  void onPressedNext() {
    Get.toNamed(RouteType.CHANGE_PASSWORD);
  }
}
