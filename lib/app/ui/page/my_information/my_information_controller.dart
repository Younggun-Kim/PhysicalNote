import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:physical_note/app/config/constant/photo_model.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/common/common_api.dart';
import 'package:physical_note/app/data/common/model/post_upload_response_model.dart';
import 'package:physical_note/app/data/user/user_api.dart';
import 'package:physical_note/app/data/workout/workout_api.dart';
import 'package:physical_note/app/ui/page/my_information/my_information_ui_mapper.dart';
import 'package:physical_note/app/ui/page/my_information/position/position_list_item_ui_state.dart';
import 'package:physical_note/app/ui/page/search_teams/items/search_teams_list_item_ui_state.dart';
import 'package:physical_note/app/ui/widgets/list_dialog/list_dialog.dart';
import 'package:physical_note/app/ui/widgets/list_dialog/list_dialog_item.dart';
import 'package:physical_note/app/utils/pagination/load_page.dart';
import 'package:physical_note/app/utils/pagination/paging_controller_ext.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/streams.dart';

import 'my_information_args.dart';

class MyInformationController extends BaseController {
  /// args.
  final args = Get.arguments as MyInformationArgs;

  /// 프로필 이미지.
  Rx<PhotoModel> profile = PhotoModel().obs;

  /// 이름.
  var name = "".obsWithController;

  /// 팀 uistate.
  SearchTeamsListItemUiState? teamUiState;

  /// 팀명 / 코치 명.
  var team = "".obs;

  /// 엘리트 여부.
  late final isElite = args.isElite.obs;

  /// 키.
  var height = "".obsWithController;

  /// 몸무게.
  var weight = "".obsWithController;

  /// 생년월일.
  var birth = "".obsWithController;

  /// 성별.
  var gender = "".obsWithController;

  /// 포지션 페이지 컨트롤러.
  final pagingController =
      PagingController<int, PositionListItemUiState>(firstPageKey: 0);

  get positionIds =>
      pagingController.itemList
          ?.where((e) => e.isSelected)
          .map((e) => e.id)
          .toList() ??
      [];

  /// 왼쪽 발.
  var leftFoot = 0.0.obs;

  /// 왼쪽 발.
  var rightFoot = 0.0.obs;

  /// 등록 버튼 enabled 여부;
  late var isEnabledRegistrationButton = CombineLatestStream(
    [
      name.behaviorStream.map((event) => event.isNotEmpty),
      team.behaviorStream.map((event) => event.isNotEmpty),
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
    pagingController.start((pageKey) => _loadWorkoutPositionData(pageKey));
  }

  void onInputBirth(String value) {
    birth.value = value;
  }

  /// 포지션 선택.
  void onTapPositionItem(PositionListItemUiState uiState) {
    final items = pagingController.itemList as List<PositionListItemUiState>;

    final newItems = items.map((item) {
      if (item.id == uiState.id) {
        item.isSelected = !uiState.isSelected;
      }
      return item;
    }).toList();

    pagingController.itemList = newItems;
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
    var uiState =
        await Get.toNamed(RouteType.SEARCH_TEAMS) as SearchTeamsListItemUiState;
    teamUiState = uiState;
    team.value = teamUiState?.clubAndCoach ?? "";
  }

  /// 엘리트/아마추어 클릭.
  void onPressedElite(bool value) {
    isElite.value = value;
  }

  /// 등록 클릭.
  void onPressedRegistration() async {
    unFocus();

    _postUser().then((value) async {
      await Future.delayed(const Duration(milliseconds: 300));
      Get.until((route) => Get.currentRoute == RouteType.HOME);
    }).catchError((error) {
      logger.e(error);
    });
  }

  /// 유저 정보 조회.
  Future<void> _loadUserData() async {
    final userApi = Get.find<UserAPI>();
    final response = await userApi.getUser();

    setScreenData(response);
  }

  /// 포지션 조회.
  Future<LoadPage<int, PositionListItemUiState>> _loadWorkoutPositionData(
      int pageKey) async {
    final workoutId = args.workoutId;
    final workoutAPI = Get.find<WorkoutAPI>();
    final response = await workoutAPI.getWorkoutPositionDetail(
        pageKey: pageKey, workoutId: workoutId);

    final isLastPage = response.last == true;
    final toUiStates = response.content
        .map((e) => positionListItemUiStateFrom(data: e))
        .toList();

    return LoadPage(
      items: toUiStates,
      isLastPage: isLastPage,
      nextPageKey: pageKey + 1,
    );
  }

  /// 유저 정보 등록/수정
  Future<void> _postUser() async {
    final userApi = Get.find<UserAPI>();
    final imageUploadResult = await _postImageUpload();
    logger.w(imageUploadResult?.toJson());
    await userApi.postUser(requestData: getUserRequestData());
  }

  /// 이미지 업로드.
  Future<PostUploadResponseModel?> _postImageUpload() async {
    final file = profile.value.file;
    if (file == null) {
      return null;
    }
    final commonApi = Get.find<CommonAPI>();
    return await commonApi.postUpload("profile", profile.value);
  }

  /// 프로필 클릭.
  Future onTapProfile(BuildContext context) async {
    final response = await Get.dialog(
      ListDialog(
        items: [
          ListDialogItem(id: 1, name: "카메라"),
          ListDialogItem(id: 2, name: "앨범"),
        ],
      ),
    );

    final result = response as ListDialogItem?;

    if (result == null) {
      return;
    }

    final imageSource =
        result.id == 1 ? ImageSource.camera : ImageSource.gallery;
    final file =
        await ImagePicker().pickImage(source: imageSource, maxWidth: 1024, imageQuality: 80);

    if (file == null) {
      return;
    }

    profile.value = PhotoModel(file: file, imageUrl: null);
  }
}
