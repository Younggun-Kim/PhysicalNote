import 'package:get/get.dart';
import 'package:physical_note/app/resources/strings/translations.dart';

enum UserType {
  elite,
  amateur;

  /// Key로 초기화
  static UserType? from(String? key) =>
      values.firstWhereOrNull((element) => element.name.toUpperCase() == key);

  @override
  String toString() {
    switch (this) {
      case elite:
        return StringRes.elite.tr;
      case amateur:
        return StringRes.amateur.tr;
    }
  }

  bool toBool() {
    switch (this) {
      case elite:
        return true;
      case amateur:
        return false;
    }
  }
}
