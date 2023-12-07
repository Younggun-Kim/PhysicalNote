import 'package:physical_note/app/data/home/model/get_home_response_model.dart';
import 'package:physical_note/app/data/home/model/hooper_index_info_model.dart';
import 'package:physical_note/app/data/hooper_index.dart';
import 'package:physical_note/app/resources/assets/assets.dart';
import 'package:physical_note/app/ui/page/home/home.dart';

extension HomeUiMapper on HomeController {
  void setScreenData(GetHomeResponseModel data) {
    userName.value = data.userSimpleInfo?.name ?? "";
    userClub.value = data.userSimpleInfo?.teamName ?? "";
    userClubCoach.value = data.userSimpleInfo?.teamCoachName ?? "";
    userImageUrl.value = data.userSimpleInfo?.profile ?? Assets.userDefault;

    hooperIndexData.value = setHooperIndexDataFrom(data.hooperIndexInfo);

    emptyWeight.value = data.urineInfoModel?.weight.toString() ?? "";
    weightPercent.value = data.urineInfoModel?.differenceFat ?? 0;
  }

  /// 후퍼인덱스 Status로 변경
  HooperIndexData? setHooperIndexDataFrom(HooperIndexInfoModel? remoteData) {
    final data = remoteData;

    if (data == null) {
      return null;
    }

    return HooperIndexData(
      sleep: HooperIndexStatus.changeFrom(data.sleep),
      stress: HooperIndexStatus.changeFrom(data.stress),
      fatigue: HooperIndexStatus.changeFrom(data.fatigue),
      musclePain: HooperIndexStatus.changeFrom(data.muscleSoreness),
    );
  }
}
