import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/user/user_api.dart';
import 'package:physical_note/app/data/workout/workout_api.dart';
import 'package:physical_note/app/ui/page/my_information/my_information_ui_mapper.dart';
import 'package:physical_note/app/ui/page/my_information/position/position_list_item_ui_state.dart';
import 'package:physical_note/app/ui/page/search_teams/items/search_teams_list_item_ui_state.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/streams.dart';

import 'my_information_args.dart';

class MyInformationController extends BaseController {
  /// args.
  final args = Get.arguments as MyInformationArgs;

  /// 이름.
  var name = "".obsWithController;

  /// 팀 uistate.
  SearchTeamsListItemUiState? teamUiState;

  /// 팀명.
  var team = "".obs;

  /// 키.
  var height = "".obsWithController;

  /// 몸무게.
  var weight = "".obsWithController;

  /// 생년월일.
  var birth = "".obsWithController;

  /// 성별.
  var gender = "".obsWithController;

  /// 포지션 목록.
  var positionItems = <PositionListItemUiState>[].obs;

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
    loadUserData();
    loadWorkoutPositionData(0);
  }

  void onInputBirth(String value) {
    birth.value = value;
  }

  /// 포지션 선택.
  void onTapPositionItem(PositionListItemUiState uiState) {
    var newItems = positionItems.map((element) {
      element.isSelected = element.id == uiState.id;
      return element;
    });
    positionItems.value = newItems.toList();
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

  /// 등록 클릭.
  void onPressedRegistration() async {
    unFocus();
    await Future.delayed(const Duration(milliseconds: 300));
    Get.until((route) => Get.currentRoute == RouteType.HOME);
  }

  /// 유저 정보 조회.
  Future<void> loadUserData() async {
    final userApi = Get.find<UserAPI>();
    final response = await userApi.getUser();

    setScreenData(response);
  }

  /// 포지션 조회.
  Future<void> loadWorkoutPositionData(int pageKey) async {
    final workoutId = args.workoutId;
    final workoutAPI = Get.find<WorkoutAPI>();
    final response = await workoutAPI.getWorkoutPositionDetail(
        pageKey: pageKey, workoutId: workoutId);

    final toUiState = response.content
        .map((e) => positionListItemUiStateFrom(data: e))
        .toList();

    positionItems.value = toUiState;
  }
}
