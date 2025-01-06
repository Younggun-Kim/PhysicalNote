// ignore_for_file: unnecessary_cast
import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/sns_type.dart';
import 'package:physical_note/app/config/constant/use_main_type.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/data/network/model/server_response_fail/server_response_fail_model.dart';
import 'package:physical_note/app/data/user/model/get_user_response_model.dart';
import 'package:physical_note/app/data/user/user_api.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/my_information/my_information_args.dart';
import 'package:physical_note/app/ui/page/search_category/item/search_category_list_item_ui_state.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/streams.dart';

import '../search_category/search_category_args.dart';
import '../term/term_args.dart';

/// 정보등록 컨트롤러.
class InformationRegistrationController extends BaseController {
  /// 종목.
  Rx<SearchCategoryListItemUiState?> category =
      (null as SearchCategoryListItemUiState?).obs;

  /// 스포츠.
  Rx<SearchCategoryListItemUiState?> sports =
      (null as SearchCategoryListItemUiState?).obs;

  /// 엘리트 선택 여부.
  // ignore: cast_from_null_always_fails
  Rx<bool?> isElite = (null as bool?).obs;

  /// 다음 버튼 활성화 여부.
  late var isEnabledNext = CombineLatestStream(
    [
      category.behaviorStream.map((event) => event != null),
      sports.behaviorStream.map((event) => event != null),
      isElite.behaviorStream.map((event) => event != null),
    ],
    (values) => values[0] && values[1] && values[2],
  ).toObs(false);

  /// 애플 소셜 팝업 노출 여부.
  var isVisibilityAppleSnsPopup = false.obs;

  /// 종목 클릭.
  void onPressedCategory() async {
    var args = SearchCategoryArgs(
      isSports: false,
      categoryId: category.value?.id,
      sportsId: null,
    );
    var result = await Get.toNamed(RouteType.SEARCH_CATEGORY, arguments: args);

    if (result is! SearchCategoryListItemUiState) {
      return;
    }

    // 둘이 다르면 스포츠 초기화.
    if (category.value != result) {
      sports.value = null;
    }

    category.value = result;
  }

  /// 스포츠 클릭.
  void onPressedSports() async {
    // 종목 선택 필수.
    if (category.value == null) {
      showToast(StringRes.pleaseSelectCategory.tr);
      return;
    }

    var args = SearchCategoryArgs(
      isSports: true,
      categoryId: category.value?.id,
      sportsId: sports.value?.id,
    );
    var result = await Get.toNamed(RouteType.SEARCH_CATEGORY, arguments: args);

    if (result is! SearchCategoryListItemUiState) {
      return;
    }

    sports.value = result;
  }

  /// 아마추어 클릭.
  void onPressedAmateur() {
    isElite.value = false;
  }

  /// 엘리트 클릭.
  void onPressedElite() {
    isElite.value = true;
  }

  /// 다음 클릭.
  Future<void> onPressedNext() async {
    final workoutId = sports.value?.id;
    final elite = isElite.value;

    if (workoutId == null || elite == null) {
      return;
    }

    /// 애플 유저면 Pass 검사 필요.
    final passVerify = await _loadUser();
    if (passVerify == false) {
      isVisibilityAppleSnsPopup.value = true;
    } else {
      moveMyInformation(workoutId, elite, null);
    }
  }

  /// 내 정보 화면으로 이동.
  void moveMyInformation(int workoutId, bool isElite, String? passCode) {
    logger.i(sports.value?.useMain);
    final args = MyInformationArgs(
      workoutId: workoutId,
      useMain: sports.value?.useMain ?? UseMain.hand,
      isElite: isElite,
      isEnteredFromHome: false,
      passCode: passCode,
    );
    Get.toNamed(RouteType.MY_INFORMATION, arguments: args);
  }

  /// 유저 정보 조회.
  Future<bool> _loadUser() async {
    setLoading(true);
    final userApi = Get.find<UserAPI>();
    final response = await userApi.getUser();
    var result = true;

    if (response is GetUserResponseModel) {
      /// Apple 유저 PassVerify 검사.
      final apple = response.socialAccounts?.firstWhereOrNull(
        (element) => element.type == UserSnsType.apple.toString(),
      );

      if (apple != null && response.passVerify == false) {
        result = false;
      }
    } else {
      final message = (response as ServerResponseFailModel?)?.toastMessage ??
          StringRes.serverError.tr;
      showToast(message);
    }

    await Future.delayed(const Duration(milliseconds: 500));
    setLoading(false);

    return result;
  }

  /// 애플 패스 인증.
  Future<String?> applePassProcess() async {
    final termArgs = TermArgs(
      snsType: UserSnsType.apple,
      accessToken: "",
    );

    return await Get.toNamed(RouteType.TERM, arguments: termArgs);
  }

  /// 애플 소셜 가입 팝업 - 확인 클릭.
  void onPressedAppleSnsPopupYes() async {
    isVisibilityAppleSnsPopup.value = false;

    final workoutId = sports.value?.id;
    final elite = isElite.value;

    if (workoutId == null || elite == null) {
      return;
    }

    final passCode = await Get.toNamed(RouteType.PASS) as String?;

    if (passCode == null) {
      return;
    }
    moveMyInformation(workoutId, elite, passCode);
  }

  /// 애플 소셜 가입 팝업 - 닫기 클릭.
  void onPressedAppleSnsPopupClose() {
    isVisibilityAppleSnsPopup.value = false;
  }
}
