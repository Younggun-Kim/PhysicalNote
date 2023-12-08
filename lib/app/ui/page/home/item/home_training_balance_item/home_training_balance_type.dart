
import 'package:physical_note/app/resources/assets/assets.dart';

/// 홈 트레이닝 밸런스 타입.
enum HomeTrainingBalanceType {
  walk,
  running,
  retired;
}

extension HomeTrainingBalanceTypeExt on HomeTrainingBalanceType {
  String toAsset() {
    if(this == HomeTrainingBalanceType.walk) {
      return Assets.walkMan;
    } else if(this == HomeTrainingBalanceType.running) {
      return Assets.runningMan;
    } else {
      return Assets.retiredMan;
    }
  }
}