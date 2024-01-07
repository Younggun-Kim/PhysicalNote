import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/user_type.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/login/model/post_check_id_response_model.dart';
import 'package:physical_note/app/data/login/model/post_login_sign_in_request_model.dart';
import 'package:physical_note/app/ui/page/sign_up/sign_up_args.dart';
import 'package:physical_note/app/utils/sns/login_process.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class SignUpController extends BaseController {
  final args = Get.arguments as SignUpArgs;

  @override
  void onInit() {
    super.onInit();
    email.behaviorStream
        .debounceTime(const Duration(milliseconds: 500))
        .listen((p0) {
      _postCheckId(p0);
    });
  }

  /// 이름.
  late final name = args.name.obsWithController;

  /// 이메일.
  final email = "".obsWithController;

  /// 이메일 유효성 검사.
  late final _isValidEmail = email.behaviorStream.map((event) => event.isEmail);
  late final isValidEmail = _isValidEmail.not().toObs(false);

  /// 이메일 중복 검사. - 입력 시 초기화.
  late final isDuplicatedEmail = false.obs;

  /// 전화번호.
  late final phoneNumber = args.phone.obsWithController;

  /// 비밀번호.
  final password = "".obsWithController;

  /// 비밀번호 확인.
  final passwordConfirm = "".obsWithController;

  /// 비밀번호 유효성 검사.
  late final _isValidPassword = CombineLatestStream(
    [
      password.behaviorStream,
      passwordConfirm.behaviorStream,
    ],
    (values) => Regex.isPassword(values[0]) && (values[0] == values[1]),
  );

  late final isValidPassword = _isValidPassword.not().toObs(false);

  /// 로그인 버튼 Enabled 여부
  late final isEnabledLoginButton = CombineLatestStream(
    [
      isValidEmail.behaviorStream,
      isValidPassword.behaviorStream,
    ],
    (values) {
      return values.every((element) => element == false);
    },
  ).toObs(false);

  /// 뒤로가기 클릭.
  void onPressedBackButton() {
    close();
  }

  /// 로그인 버튼 클릭.
  void onPressedLoginButton() async {
    unFocus();
    await Future.delayed(const Duration(milliseconds: 300));

    setLoading(true);
    final loginProcess = Get.find<LoginProcess>();
    final requestData = PostLoginSignInRequestModel(
      loginId: email.value,
      passCode: args.passToken,
      password: password.value,
      type: UserSnsType.idPw.toString(),
    );

    final moveType = await loginProcess.signInAndMove(requestData: requestData);

    setLoading(false);
    loginProcess.movePage(moveType);
  }

  /// 아이디 중복 확인.
  Future _postCheckId(String loginId) async {
    final loginApi = Get.find<LoginAPI>();
    final response = await loginApi.postLoginSignInCheckId(loginId: loginId);

    if (response is PostCheckIdResponseModel) {
      isDuplicatedEmail.value = response.duplicate ?? false;
    } else {
      isDuplicatedEmail.value = false;
    }
  }
}
