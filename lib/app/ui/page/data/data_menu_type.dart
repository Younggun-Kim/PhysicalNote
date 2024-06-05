import 'package:get/get.dart';
import 'package:physical_note/app/resources/strings/translations.dart';

enum DataMenuType {
  wellness(0),
  intensity(1),
  injury(2);

  final int page;

  const DataMenuType(this.page);

  /// Key로 초기화
  static DataMenuType? fromPage(int? key) =>
      values.firstWhereOrNull((element) => element.page == key);

  @override
  String toString() {
    switch (this) {
      case wellness:
        return StringRes.wellness.tr;
      case intensity:
        return StringRes.workoutIntensity.tr;
      case injury:
        return StringRes.injuryManagement.tr;
    }
  }
}
