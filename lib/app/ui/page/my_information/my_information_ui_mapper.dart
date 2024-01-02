import 'package:physical_note/app/data/user/model/get_user_response_model.dart';
import 'package:physical_note/app/data/user/model/post_user_request_model.dart';
import 'package:physical_note/app/data/workout/model/get_workout_position_detail_response_model.dart';
import 'package:physical_note/app/ui/page/my_information/my_information_controller.dart';
import 'package:physical_note/app/ui/page/my_information/position/position_list_item_ui_state.dart';

import '../search_teams/items/search_teams_list_item_ui_state.dart';

extension MyInformationUiMapper on MyInformationController {
  void setScreenData(GetUserResponseModel? response) {
    /// 이름.
    name.value = response?.name ?? "";

    /// 팀명 / 코치 명.
    teamUiState.value = _getTeam(response);

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

  /// 포지션 UiState Mapper.
  PositionListItemUiState positionListItemUiStateFrom({
    required GetWorkoutPositionDetailResponseModel data,
  }) {
    return PositionListItemUiState(
      id: data.id,
      name: data.name,
    );
  }

  /// 팀 가져오기.
  SearchTeamsListItemUiState? _getTeam(GetUserResponseModel? response) {
    final teamId = response?.teamId;
    final teamHeadCoach = response?.teamHeadCoach;
    final teamName = response?.teamName;

    if (teamId == null || teamHeadCoach == null || teamName == null) {
      return null;
    }

    return SearchTeamsListItemUiState(
      id: teamId,
      clubName: teamName,
      coachName: teamHeadCoach,
    );
  }

  /// Screen의 유저 요청 데이터 가져오기.
  PostUserRequestModel getUserRequestData(
          {required String? profile,
          required int workoutId,
          required bool itsElite}) =>
      PostUserRequestModel(
        height: double.parse(height.value),
        weight: double.parse(weight.value),
        leftValue: leftFoot.value.toInt(),
        rightValue: rightFoot.value.toInt(),
        teamId: 1,
        positionIds: positionIds,
        profile: profile,
        workoutId: workoutId,
        userType: itsElite ? "ELITE" : "AMATEUR",
      );
}
