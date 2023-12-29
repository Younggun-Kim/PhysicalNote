import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/user_type.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/login/model/post_login_find_id_request_model.dart';
import 'package:physical_note/app/data/login/model/post_login_find_id_response_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/ui/page/find_id_complete/find_id_complete.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import '../../../config/routes/routes.dart';
import 'find_id_args.dart';

class FindIdController extends BaseController {
  /// Args.
  final args = Get.arguments as FindIdArgs;

  /// 이름.
  late final name = args.name.obsWithController;

  /// 이름 유효성 검사.
  late final _isValidName =
      name.behaviorStream.map((event) => event.length > 2);
  late final isValidName = _isValidName.toObs(false);

  /// 전화번호.
  late final phoneNumber = args.phone.obsWithController;

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
    setLoading(true);
    final loginApi = Get.find<LoginAPI>();
    final response = await loginApi.postLoginFindId(
      requestData: PostLoginFindIdRequestModel(
        code: args.passToken,
        loginType: UserSnsType.idPw.name,
      ),
    );

    await Future.delayed(const Duration(seconds: 1));

    setLoading(false);

    if (response is PostLoginFindIdResponseModel) {
      final email = response.accounts
          ?.firstWhereOrNull((element) => element.type == UserSnsType.idPw.name)
          ?.email;

      if (response.status == false) {
        /// 가입된 계정이 없습니다.
      } else if (email != null) {
        Get.toNamed(
          RouteType.FIND_ID_COMPLETE,
          arguments: FindIdCompleteArgument(
            name: args.name,
            email: email,
          ),
        );
      } else {
        /// SNS 계정
      }
    } else {
      final message =
          (response as ServerResponseFailModel?)?.devMessage ?? "서버 에러";
      showToast(message);
    }
  }
}
