import 'package:get/get.dart';
import 'package:physical_note/app/config/constant/hooper_index_status.dart';
import 'package:physical_note/app/config/constant/urine_status_type.dart';
import 'package:physical_note/app/data/home/model/home_model.dart';
import 'package:physical_note/app/resources/resources.dart';
import 'package:physical_note/app/ui/page/home2/home_controller.dart';

extension HomeUiMapper on HomeController {
  void setScreen(GetHomeResponseModel? model) {
    /// 후퍼인덱스
    final hooperIndex = model?.hooperIndexInfo;

    /// 웰리니스 - 소변검사
    urineDescription.value = _urineDescription(model?.urineInfo);
  }

  /// 소변 데이터를 설명으로 변경
  String _urineDescription(UrineInfoModel? urineData) {
    final urine = UrineStatusType.typeFrom(urineData?.urine ?? '');
    final differenceFat = urineData?.differenceFat;

    if (urine != UrineStatusType.none || differenceFat == null) {
      return StringRes.dataNotAvailable.tr;
    }

    final differenceFatNum = double.parse(
      differenceFat.replaceAll(RegExp(r'[^\d.-]'), ''),
    );

    final isPositiveUrine = urine.isPositive();

    if (differenceFatNum >= 2) {
      return isPositiveUrine
          ? StringRes.urineWeightOverMoistureGood.tr
          : StringRes.urineWeightOverMoistureBad.tr;
    } else if (differenceFatNum <= -2) {
      return isPositiveUrine
          ? StringRes.urineWeightLessMoistureGood.tr
          : StringRes.urineWeightLessMoistureBad.tr;
    } else {
      return isPositiveUrine
          ? StringRes.urineWeightGoodMoistureGood.tr
          : StringRes.urineWeightGoodMoistureBad.tr;
    }
  }
}
