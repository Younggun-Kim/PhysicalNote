// ignore_for_file: unnecessary_cast

import 'package:flutter/cupertino.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:physical_note/app/config/constant/photo_model.dart';
import 'package:physical_note/app/config/constant/user_type.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/common/common_api.dart';
import 'package:physical_note/app/data/common/model/post_upload_response_model.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/user/model/get_user_response_model.dart';
import 'package:physical_note/app/data/user/user_api.dart';
import 'package:physical_note/app/data/user/user_storage.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/my_information/my_information_ui_mapper.dart';
import 'package:physical_note/app/ui/page/my_information/position/position_list_item_ui_state.dart';
import 'package:physical_note/app/ui/page/position/position.dart';
import 'package:physical_note/app/ui/page/search_teams/items/search_teams_list_item_ui_state.dart';
import 'package:physical_note/app/ui/widgets/list_dialog/list_dialog.dart';
import 'package:physical_note/app/ui/widgets/list_dialog/list_dialog_item.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/streams.dart';

import 'my_information_args.dart';

class MyInformationController extends BaseController {
  /// args.
  final args = Get.arguments as MyInformationArgs?;

  /// 프로필 이미지.
  Rx<PhotoModel> profile = PhotoModel().obs;

  /// 이름.
  var name = "".obsWithController;

  /// 팀 uistate.
  var teamUiState = (null as SearchTeamsListItemUiState?).obs;

  /// 엘리트 여부.
  late final isElite = (args?.isElite).obs;

  /// 키.
  var height = "".obsWithController;

  /// 몸무게.
  var weight = "".obsWithController;

  /// 생년월일.
  var birth = "".obsWithController;

  /// 성별.
  var gender = "".obsWithController;

  /// 포지션.
  var positions = <PositionListItemUiState>[].obs;

  /// 왼쪽 발.
  var leftFoot = 0.0.obs;

  /// 왼쪽 발.
  var rightFoot = 0.0.obs;

  /// 등록 버튼 enabled 여부;
  late var isEnabledRegistrationButton = CombineLatestStream(
    [
      name.behaviorStream.map((event) => event.isNotEmpty),
      teamUiState.behaviorStream.map((event) => event?.id != null),
      height.behaviorStream.map((event) => event.isNotEmpty),
      weight.behaviorStream.map((event) => event.isNotEmpty),
      birth.behaviorStream.map((event) => event.length == 8),
      gender.behaviorStream.map((event) => event.isNotEmpty),
    ],
    (values) => values.every((element) => element == true),
  ).toObs(false);

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  /// 생년월일 입력.
  void onInputBirth(String value) {
    birth.value = value;
  }

  /// 포지션 찾기 버튼 클릭.
  void onPressedSearchPosition() async {
    final workoutId = args?.workoutId;
    if (workoutId == null) {
      return;
    }
    final positionArgs = PositionArgs(workoutId: workoutId);
    final positionList = await Get.toNamed(
      RouteType.POSITION,
      arguments: positionArgs,
    ) as List<PositionListItemUiState>;

    if (positionList.isNotEmpty) {
      /// 기존 포지션과 비교해서 set 으로 하기.
      final positionSet = <PositionListItemUiState>{
        ...positions,
        ...positionList
      };
      // final positionSet = Set<PositionListItemUiState>.from(positions.toList())..addAll(positionList);
      positions.value = positionSet.toList();
    }
  }

  /// 포지션 삭제 클릭.
  void onPressedPositionDeleteButton(PositionListItemUiState uiState) {
    var list = positions.toList();

    list.removeWhere((element) => element == uiState);

    positions.value = list;
  }

  /// 왼쪽 발 변경.
  void onChangeLeftFoot(newValue) {
    leftFoot.value = newValue;
    rightFoot.value = 10.0 - newValue;
  }

  /// 오른쪽 발 변경.
  void onChangeRightFoot(newValue) {
    rightFoot.value = newValue;
    leftFoot.value = 10.0 - newValue;
  }

  /// 팀명 클릭.
  Future<void> onPressedTeamName() async {
    final uiState =
        await Get.toNamed(RouteType.SEARCH_TEAMS) as SearchTeamsListItemUiState;
    teamUiState.value = uiState;
  }

  /// 엘리트/아마추어 클릭.
  void onPressedElite(bool value) {
    isElite.value = value;
  }

  /// 등록 클릭.
  void onPressedRegistration() async {
    unFocus();
    await _postUser();
  }

  /// 유저 정보 조회.
  Future<void> _loadUserData() async {
    final userApi = Get.find<UserAPI>();
    final response = await userApi.getUser();

    if (response is GetUserResponseModel) {
      setScreenData(response);
    } else {
      final message =
          (response as ServerResponseFailModel?)?.devMessage ?? "서버 에러";
      showToast(message);
    }
  }

  /// 유저 정보 등록/수정
  Future<void> _postUser() async {
    final userApi = Get.find<UserAPI>();
    final uploadResponse = await _postImageUpload();
    final profile = uploadResponse?.url?.first;
    final workoutId = args?.workoutId;
    final elite = isElite.value;
    final teamId = teamUiState.value?.id;

    if (workoutId == null || elite == null || teamId == null) {
      return;
    }

    final requestData = getUserRequestData(
      profile: profile,
      workoutId: workoutId,
      isElite: elite,
      teamId: teamId,
    );
    final response = await userApi.postUser(requestData: requestData);

    // TODO: 진입점에 따라 처리 방식을 구분해야 함.
    if (response is GetUserResponseModel) {
      Get.offAllNamed(RouteType.TEAM_REQUEST);
    } else {
      final message =
          (response as ServerResponseFailModel?)?.devMessage ?? "서버 에러";
      showToast(message);
    }
  }

  /// 이미지 업로드.
  Future<PostUploadResponseModel?> _postImageUpload() async {
    final file = profile.value.file;
    if (file == null) {
      return null;
    }
    final commonApi = Get.find<CommonAPI>();
    final response = await commonApi.postUpload("profile", profile.value);

    PostUploadResponseModel? result;

    if (response is PostUploadResponseModel) {
      result = response;
    } else {
      final message =
          (response as ServerResponseFailModel?)?.devMessage ?? "서버 에러";
      showToast(message);
    }

    return result;
  }

  /// 프로필 클릭.
  Future onTapProfile(BuildContext context) async {
    final response = await Get.dialog(
      ListDialog(
        items: [
          ListDialogItem(id: 1, name: StringRes.camera.tr),
          ListDialogItem(id: 2, name: StringRes.album.tr),
        ],
      ),
    );

    final result = response as ListDialogItem?;

    if (result == null) {
      return;
    }

    final imageSource =
        result.id == 1 ? ImageSource.camera : ImageSource.gallery;
    final file = await ImagePicker()
        .pickImage(source: imageSource, maxWidth: 1024, imageQuality: 80);

    if (file == null) {
      return;
    }

    profile.value = PhotoModel(file: file, imageUrl: null);
  }

  /// 로그아웃.
  void logout() {
    final userStorage = UserStorage();

    /// 저장된 토근 삭제
    userStorage.apiKey.val = "";

    /// 네이버 로그아웃.
    if (userStorage.snsType.val == UserSnsType.naver.toString()) {
      FlutterNaverLogin.logOutAndDeleteToken();
    }

    /// 로그인으로 이동.
    Get.offAllNamed(RouteType.LOGIN);
  }
}
