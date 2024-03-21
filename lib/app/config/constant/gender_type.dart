import 'package:get/get.dart';
import 'package:physical_note/app/resources/strings/translations.dart';

/// 성별 타입
enum GenderType {
  male(code: 'M'),
  female(code: 'F');

  final String code;

  const GenderType({required this.code});

  static GenderType? from(String? key) =>
      values.firstWhereOrNull((element) => element.code == key);

  @override
  String toString() {
    switch (this) {
      case male:
        return StringRes.male.tr;
      case female:
        return StringRes.female.tr;
    }
  }
}
