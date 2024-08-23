import 'package:get/get.dart';
import 'package:physical_note/app/resources/strings/translations.dart';

/// 운동 강도 타입
enum IntensityType {
  sports,
  physical;

  /// UpperCase Name 얻기
  String get upperName => name.toUpperCase();

  /// Kor 얻기
  String get toKor => _toKor();

  String _toKor() {
    switch (this) {
      case IntensityType.sports:
        return StringRes.sports.tr;
      case IntensityType.physical:
        return StringRes.physical.tr;
    }
  }
}
