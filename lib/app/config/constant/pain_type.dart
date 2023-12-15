/// 통증양상 타입.
enum PainType {
  /// 알 수 없음.
  none,

  /// 통증양상 : 찌릿함
  tingling,

  /// 통증양상 : 압박감
  pressure,

  /// 통증양상 : 힘이 빠짐
  weakness,

  /// 통증양상 : 저리거나 둔해짐
  numbness,

  /// 통증양상 : 뭉치거나 올라올 것 같은
  tightness,

  /// 통증양상 : 특정자세에 민감
  postureSensitive,

  /// 통증양상 : 쑤시는
  aching,

  /// 통증양상 : 타이트
  stiff,

  /// 통증양상 : 뻐근함
  soreness,

  /// 통증양상 : 날카로운 통증
  sharpPain,

  /// 통증양상 : 통증이 주변으로 확산
  radiatingPain;

  @override
  String toString() {
    switch (this) {
      case PainType.tingling:
        return "짜릿함";
      case pressure:
        return "압박감";
      case weakness:
        return "힘이 빠짐";
      case numbness:
        return "저리거나 둔해짐";
      case tightness:
        return "뭉치거나 올라올 것 같은";
      case postureSensitive:
        return "특정자세에 민감";
      case aching:
        return "쑤시는";
      case stiff:
        return "타이트";
      case soreness:
        return "뻐근함";
      case sharpPain:
        return "날카로운 통증";
      case radiatingPain:
        return "통증이 주변으로 확산";
      default:
        return "";
    }
  }

  static PainType from(String? type) {
    switch (type) {
      case "TINGLING":
        return PainType.tingling;
      case "PRESSURE":
        return PainType.pressure;
      case "WEAKNESS":
        return PainType.weakness;
      case "NUMBNESS":
        return PainType.numbness;
      case "TIGHTNESS":
        return PainType.tightness;
      case "POSTURE_SENSITIVE":
        return PainType.postureSensitive;
      case "ACHING":
        return PainType.aching;
      case "STIFF":
        return PainType.stiff;
      case "SORENESS":
        return PainType.soreness;
      case "SHARP_PAIN":
        return PainType.sharpPain;
      case "RADIATING_PAIN":
        return PainType.radiatingPain;
      default:
        return PainType.none;
    }
  }
}
