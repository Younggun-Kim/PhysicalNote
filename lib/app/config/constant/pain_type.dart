import 'package:get/get.dart';
import 'package:physical_note/app/resources/strings/translations.dart';

/// 통증양상 타입.
enum PainType {
  /// 통증양상 : 찌릿함
  tingling("TINGLING"),

  /// 통증양상 : 압박감
  pressure("PRESSURE"),

  /// 통증양상 : 힘이 빠짐
  weakness("WEAKNESS"),

  /// 통증양상 : 저리거나 둔해짐
  numbness("NUMBNESS"),

  /// 통증양상 : 뭉치거나 올라올 것 같은
  tightness("TIGHTNESS"),

  /// 통증양상 : 쑤시는
  aching("ACHING"),

  /// 통증양상 : 특정자세에 민감
  postureSensitive("POSTURE_SENSITIVE"),
  
  /// 통증양상 : 타이트
  stiff("STIFF"),

  /// 통증양상 : 뻐근함
  soreness("SORENESS"),

  /// 통증양상 : 날카로운 통증
  sharpPain("SHARP_PAIN"),

  /// 통증양상 : 통증이 주변으로 확산
  radiatingPain("RADIATING_PAIN");

  final String serverKey;

  const PainType(this.serverKey);

  /// Key로 초기화
  static PainType? from(String? key) =>
      values.firstWhereOrNull((element) => element.serverKey == key);

  @override
  String toString() {
    switch (this) {
      case PainType.tingling:
        return StringRes.tingling.tr;
      case pressure:
        return StringRes.pressure.tr;
      case weakness:
        return StringRes.weakness.tr;
      case numbness:
        return StringRes.numbness.tr;
      case tightness:
        return StringRes.tightness.tr;
      case postureSensitive:
        return StringRes.postureSensitive.tr;
      case aching:
        return StringRes.aching.tr;
      case stiff:
        return StringRes.stiff.tr;
      case soreness:
        return StringRes.soreness.tr;
      case sharpPain:
        return StringRes.sharpPain.tr;
      case radiatingPain:
        return StringRes.radiatingPain.tr;
    }
  }
}
