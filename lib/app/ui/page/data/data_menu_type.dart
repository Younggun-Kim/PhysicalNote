import 'package:get/get.dart';
import 'package:physical_note/app/resources/strings/translations.dart';

enum DataMenuType {
  wellness,
  intensity,
  injury;

  @override
  String toString() {
    switch (this) {
      case wellness:
        return StringRes.wellness.tr;
      case intensity:
        return StringRes.workoutIntensity.tr;
      case injury:
        return StringRes.injuryCheck.tr;
    }
  }
}
