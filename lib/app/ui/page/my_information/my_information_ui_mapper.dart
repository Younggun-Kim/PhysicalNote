import 'package:intl/intl.dart';
import 'package:physical_note/app/data/user/model/get_user_response_model.dart';
import 'package:physical_note/app/ui/page/my_information/my_information_controller.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

extension MyInformationUiMapper on MyInformationController {

  void setScreenData(GetUserResponseModel? response) {

    /// 이름.
    name.value = response?.name ?? "";

    /// 팀명.
    team.value = response?.teamName ?? "";

    /// 키.
    height.value = response?.height?.toInt().toString() ?? "";

    /// 몸무게.
    weight.value = response?.weight?.toInt().toString() ?? "";

    /// 생년월일.
    birth.value = response?.birthDate?.replaceAll("-", "") ?? "";

    /// 성별.
    gender.value = response?.gender ?? "";

    // TODO: 포지션 파싱.
    /// 포지션.

    /// 왼 발
    leftFoot.value = response?.leftValue ?? 0;

    /// 오른쪽 발.
    rightFoot.value = response?.rightValue ?? 0;
  }
}