import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/gender_type.dart';
import 'package:physical_note/app/config/constant/sns_type.dart';
import 'package:physical_note/app/data/login/login_api.dart';
import 'package:physical_note/app/data/login/model/post_check_id_response_model.dart';
import 'package:physical_note/app/data/login/model/post_login_sign_in_request_model.dart';
import 'package:physical_note/app/utils/sns/login_process.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class SignUpController extends BaseController {
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
  late final name = "".obsWithController;
  late final _isValidName =
      name.behaviorStream.map((event) => event.length >= 2).not();

  /// 이메일.
  final email = "".obsWithController;

  /// 이메일 유효성 검사.
  late final _isValidEmail = email.behaviorStream.map((event) => event.isEmail);
  late final isValidEmail = _isValidEmail.not().toObs(false);

  /// 이메일 중복 검사. - 입력 시 초기화.
  late final isDuplicatedEmail = false.obs;

  /// 전화번호.
  late final phoneNumber = "".obsWithController;
  late final _isValidPhoneNumber = phoneNumber.behaviorStream
      .map((event) => Regex.isPhoneNumber(event))
      .not();

  /// 생년월일.
  late final birth = "".obsWithController;
  late final _isValidBirth = birth.behaviorStream
      .map((event) => event.length == 8 && Regex.isBirth(event))
      .not();

  /// 성별
  late final gender = (null as GenderType?).obs;
  late final _isValidGender = gender.behaviorStream
      .map((event) => GenderType.values.contains(event) == true)
      .not();

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
      _isValidName,
      isValidEmail.behaviorStream,
      isDuplicatedEmail.behaviorStream,
      _isValidPhoneNumber,
      isValidPassword.behaviorStream,
      _isValidBirth,
      _isValidGender,
    ],
    (values) {
      return values.every((element) => element == false);
    },
  ).toObs(false);

  /// 뒤로가기 클릭.
  void onPressedBackButton() {
    close();
  }

  /// 성별 클릭.
  void onPressedGenderButton(GenderType? newGender) {
    gender.value = newGender;
  }

  /// 로그인 버튼 클릭.
  void onPressedLoginButton() async {
    unFocus();
    await Future.delayed(const Duration(milliseconds: 300));

    setLoading(true);
    final isKor = LocalizationUtil.isKor;
    final birthValue = birth.value;
    final korBirthDate =  "${birthValue.substring(0, 4)}-${birthValue.substring(4, 6)}-${birthValue.substring(6)}";
    final engBirthDate =  "${birthValue.substring(4)}-${birthValue.substring(0, 2)}-${birthValue.substring(2, 4)}";
    final birthDate= isKor ? korBirthDate : engBirthDate;
    final loginProcess = Get.find<LoginProcess>();
    final requestData = PostLoginSignInRequestModel(
      loginId: email.value,
      passCode: "",
      password: password.value,
      type: UserSnsType.idPw.toString(),
      name: name.value,
      cellphoneNo: phoneNumber.value,
      birthDate: birthDate,
      gender: gender.value?.code,
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
