import 'package:get/get.dart';
import 'package:physical_note/app/resources/strings/translations.dart';

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

  @override
  String toString() {
    switch (this) {
      case InjuryType.contact:
        return StringRes.injuryTypeContact.tr;
      case InjuryType.nonContact:
        return StringRes.injuryTypeNonContact.tr;
      case InjuryType.disease:
        return StringRes.injuryTypeDisease.tr;
    }
  }
}
