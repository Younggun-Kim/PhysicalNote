import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/user_type.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/login/model/post_login_find_id_request_model.dart';
import 'package:physical_note/app/ui/page/find_id_complete/find_id_complete.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import '../../../config/routes/routes.dart';

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
  Future<void> onPressedLogin() async {
    // TODO: Pass 리턴 받아야 함.
    const passCode = "";
    final loginApi = Get.find<LoginAPI>();
    final response = await loginApi.postLoginFindId(
      requestData: PostLoginFindIdRequestModel(
        code: passCode,
        loginType: UserSnsType.idPw.name,
      ),
    );

    if (response == null || response.status == false) {
      return;
    }

    Get.toNamed(
      RouteType.FIND_ID_COMPLETE,
      arguments: FindIdCompleteArgument(
        name: "홍길동",
        email: "test@test.com",
      ),
    );
  }
}
