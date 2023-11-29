// ignore_for_file: unnecessary_cast
import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/search_category/item/search_category_list_item_ui_state.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/streams.dart';

import '../search_category/search_category_args.dart';

/// 정보등록 컨트롤러.
class InformationRegistrationController extends BaseController {
  /// 종목.
  Rx<SearchCategoryListItemUiState?> category =
      (null as SearchCategoryListItemUiState?).obs;

  /// 스포츠.
  Rx<SearchCategoryListItemUiState?> sports =
      (null as SearchCategoryListItemUiState?).obs;

  /// 아마추어 선택 여부.
  var isAmateur = false.obs;

  /// 엘리트 선택 여부.
  var isElite = false.obs;

  /// 다음 버튼 활성화 여부.
  late var isEnabledNext = CombineLatestStream(
    [
      category.behaviorStream.map((event) => event != null),
      sports.behaviorStream.map((event) => event != null),
      isAmateur.behaviorStream,
      isElite.behaviorStream
    ],
    (values) => values[0] && values[1] && (values[2] || values[3]),
  ).toObs(false);

  /// 종목 클릭.
  void onPressedCategory() async {
    var args = SearchCategoryArgs(
      isSports: false,
      categoryId: category.value?.id,
      sportsId: null,
    );
    var result = await Get.toNamed(RouteType.SEARCH_CATEGORY, arguments: args);

    if (result is! SearchCategoryListItemUiState) {
      category.value = null;
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
      sports.value = null;
      return;
    }

    sports.value = result;
  }

  /// 아마추어 클릭.
  void onPressedAmateur() {
    isAmateur.value = true;
    isElite.value = false;
  }

  /// 엘리트 클릭.
  void onPressedElite() {
    isAmateur.value = false;
    isElite.value = true;
  }

  /// 다음 클릭.
  Future<void> onPressedNext() async {
    await Get.toNamed(RouteType.MY_INFORMATION);
  }
}
