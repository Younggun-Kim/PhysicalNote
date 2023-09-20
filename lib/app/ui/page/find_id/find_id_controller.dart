import 'package:get/get.dart';
import 'package:physical_note/app/routes/routes.dart';
import 'package:physical_note/app/ui/page/find_id_complete/find_id_complete.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class FindIdController extends BaseController {
  /// 이름.
  final name = "".obsWithController;

  /// 이름 유효성 검사.
  late final _isValidName =
      name.behaviorStream.map((event) => event.length > 2);
  late final isValidName = _isValidName.toObs(false);

  /// 전화번호.
  final phoneNumber = "".obsWithController;

  /// 전화번호 유효성 검사.
  late final _isValidPhoneNumber =
      phoneNumber.behaviorStream.map((event) => Regex.isPhoneNumber(event));
  late final isValidPhoneNumber = _isValidPhoneNumber.toObs(false);

  /// 로그인 Enabled 여부.
  late final isEnabledLogin = CombineLatestStream(
    [
      isValidName.behaviorStream,
      isValidPhoneNumber.behaviorStream,
    ],
    (values) => values.every((element) => element == true),
  ).toObs(false);

  /// 로그인 버튼 클릭.
  void onPressedLogin() {
    Get.toNamed(
      RouteType.FIND_ID_COMPLETE,
      arguments: FindIdCompleteArgument(
        name: "name",
        email: "email@email.com",
      ),
    );
  }
}
