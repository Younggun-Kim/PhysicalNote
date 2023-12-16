import 'package:get/get.dart';

const _contact = "CONTACT";
const _disease = "DISEASE";
const _nonContact = "NON_CONTACT";

/// 부상 타입.
enum InjuryType {
  contact(_contact),
  disease(_disease),
  nonContact(_nonContact);

  final String rawValue;

  const InjuryType(this.rawValue);

  static InjuryType? from(String? rawValue) =>
      values.firstWhereOrNull((e) => e.rawValue == rawValue);

  String toKor() {
    switch (this) {
      case InjuryType.contact:
        return "접촉";
      case InjuryType.nonContact:
        return "비접촉";
      case InjuryType.disease:
        return "질병";
    }
  }
}
