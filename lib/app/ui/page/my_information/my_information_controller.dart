import 'package:get/get.dart';
import 'package:physical_note/app/ui/page/my_information/position/position_list_item_ui_state.dart';
import 'package:physical_note/app/utils/utils.dart';

class MyInformationController extends BaseController {
  /// 이름.
  var name = "".obsWithController;

  /// 키.
  var height = "".obsWithController;

  /// 몸무게.
  var weight = "".obsWithController;

  /// 생년월일.
  var birth = "".obsWithController;

  /// 성별.
  var gender = "".obsWithController;

  /// 포지션 목록.
  var positionItems = <PositionListItemUiState>[
    PositionListItemUiState(id: 1, name: "축구1", isSelected: false),
    PositionListItemUiState(id: 2, name: "축구2", isSelected: false),
    PositionListItemUiState(id: 3, name: "축구3", isSelected: false),
    PositionListItemUiState(id: 4, name: "축구4", isSelected: false),
    PositionListItemUiState(id: 5, name: "축구5", isSelected: false),
    PositionListItemUiState(id: 6, name: "축구6", isSelected: false),
    PositionListItemUiState(id: 7, name: "축구7", isSelected: false),
    PositionListItemUiState(id: 8, name: "축구8", isSelected: false),
    PositionListItemUiState(id: 9, name: "축구9", isSelected: false),
    PositionListItemUiState(id: 10, name: "축구10", isSelected: false),
  ].obs;


  /// 왼쪽 발.
  var leftFoot = 0.0.obs;

  /// 왼쪽 발.
  var rightFoot = 0.0.obs;

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
  }

  /// 오른쪽 발 변경.
  void onChangeRightFoot(newValue) {
    rightFoot.value = newValue;
  }
}
