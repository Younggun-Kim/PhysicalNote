import 'package:physical_note/app/data/home/model/get_home_response_model.dart';
import 'package:physical_note/app/data/home/model/hooper_index_info_model.dart';
import 'package:physical_note/app/data/home/model/urine_info_model.dart';
import 'package:physical_note/app/data/hooper_index_status.dart';
import 'package:physical_note/app/resources/assets/assets.dart';
import 'package:physical_note/app/ui/page/home/home.dart';
import 'package:physical_note/app/utils/logger/logger.dart';

import 'model/home_urine_model.dart';

extension HomeUiMapper on HomeController {
  void setScreenData(GetHomeResponseModel data) {
    userName.value = data.userSimpleInfo?.name ?? "";
    userClub.value = data.userSimpleInfo?.teamName ?? "";
    userClubCoach.value = data.userSimpleInfo?.teamCoachName ?? "";
    userImageUrl.value = data.userSimpleInfo?.profile ?? Assets.userDefault;
    hooperIndexData.value = setHooperIndexDataFrom(data.hooperIndexInfo);
    urineData.value = setHomeUrineModelFrom(data.urineInfo);
  }

  /// 후퍼인덱스 매핑
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

  /// 소변검사 매핑
  HomeUrineModel? setHomeUrineModelFrom(UrineInfoModel? remoteData) {
    final data = remoteData;
    final urineId = data?.id;

    logger.w("remoteData : $remoteData");

    if (data == null || urineId == null) {
      return null;
    }

    return HomeUrineModel(
      id: urineId,
      weight: data.weight?.toInt() ?? 0,
      differenceFat: data.differenceFat?.toInt() ?? 0,
      urine: data.urine ?? "",
    );
  }
}
