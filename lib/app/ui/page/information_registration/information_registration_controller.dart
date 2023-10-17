import 'package:get/get.dart';
import 'package:physical_note/app/config/routes/routes.dart';
import 'package:physical_note/app/utils/getx/base_controller.dart';
import 'package:physical_note/app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import '../search_category/search_category_args.dart';

/// 정보등록 컨트롤러.
class InformationRegistrationController extends BaseController {
  /// 종목.
  var category = "".obs;

  /// 스포츠.
  var sports = "".obs;

  /// 아마추어 선택 여부.
  var isAmateur = false.obs;

  /// 엘리트 선택 여부.
  var isElite = false.obs;

  /// 다음 버튼 활성화 여부.
  late var isEnabledNext = CombineLatestStream(
    [
      category.behaviorStream.map((event) => event.isNotEmpty),
      sports.behaviorStream.map((event) => event.isNotEmpty),
      isAmateur.behaviorStream,
      isElite.behaviorStream
    ],
        (values) => values[0] && values[1] && (values[2] || values[3]),
  ).toObs(false);

  /// 종목 클릭.
  void onPressedCategory() async {
    var args = SearchCategoryArgs(false);
    var result = await Get.toNamed(RouteType.SEARCH_CATEGORY, arguments:args);
    category.value = result;
  }

  /// 스포츠 클릭.
  void onPressedSports() async {
    var args = SearchCategoryArgs(true);
    var result = await Get.toNamed(RouteType.SEARCH_CATEGORY, arguments:args);
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
  void onPressedNext() {
    Get.toNamed(RouteType.MY_INFORMATION);
  }
}
