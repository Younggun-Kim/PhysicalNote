import 'package:get/get.dart';

/// 근육 타입.
enum MuscleType {
  /// 장내전근
  adductorLongus("ADDUCTOR_LONGUS"),

  /// 대내전근
  adductorMagnus("ADDUCTOR_MAGNUS"),

  /// 이두근
  biceps("BICEPS"),

  /// 반건반막양근
  bicepsFemoris("BICEPS_FEMORIS"),

  /// 상완근
  brachialis("BRACHIALIS"),

  /// 완요골근
  brachioradialis("BRACHIORADIALIS"),

  /// 삼각근
  deltoid("DELTOID"),

  /// 충지신근
  extensorCarpiUlnaris("EXTENSOR_CARPI_ULNARIS"),

  /// 장모지신근
  extensorDigitorumBrevis("EXTENSOR_DIGITORUM_BREVIS"),

  /// 장지신근
  extensorDigitorumLongus("EXTENSOR_DIGITORUM_LONGUS"),

  /// 외복사근
  externalOblique("EXTERNAL_OBLIQUE"),

  /// 주근
  flexorCarpiRadialis("FLEXOR_CARPI_RADIALIS"),

  /// 둔근
  gluteus("GLUTEUS"),

  /// 비복근
  gracilis("GRACILIS"),

  /// 장골근
  iliacus("ILIACUS"),

  /// 장경인대
  iliotibialBand("ILIOTIBIAL_BAND"),

  /// 오훼완근
  infraspinatus("INFRASPINATUS"),

  /// 대퇴직근
  largeRetirement("LARGE_RETIREMENT"),

  /// 외측광근
  lateralGastrocnemius("LATERAL_GASTROCNEMIUS"),

  /// 광배근
  latissimusDorsi("LATISSIMUS_DORSI"),

  /// 내측광근
  medialGastrocnemius("MEDIAL_GASTROCNEMIUS"),

  /// 소원근
  oblique("OBLIQUE"),

  /// 척측수근신근
  palmarisLongus("PALMARIS_LONGUS"),

  /// 대흉근
  pectoralisMajor("PECTORALIS_MAJOR"),

  /// 장비골근
  peroneusBrevis("PERONEUS_BREVIS"),

  /// 중간광근
  peroneusLongus("PERONEUS_LONGUS"),

  /// 원회내근
  pronatorTeres("PRONATOR_TERES"),

  /// 대요근
  psoasMajor("PSOAS_MAJOR"),

  /// 치골근
  pubicus("PUBICUS"),

  /// 대원근
  quadratusLumborum("QUADRATUS_LUMBORUM"),

  /// 복직근
  rectusAbdominis("RECTUS_ABDOMINIS"),

  /// 대퇴이두근
  rectusFemoris("RECTUS_FEMORIS"),

  /// 가자미근
  sartorius("SARTORIUS"),

  /// 장경인대
  semimembranosus("SEMIMEMBRANOSUS"),

  /// 척추기립근
  semitendinosus("SEMITENDINOSUS"),

  /// 장장근
  serratusAnterior("SERRATUS_ANTERIOR"),

  /// 박근
  soleus("SOLEUS"),

  /// 요측수근신근
  supinator("SUPINATOR"),

  /// 대퇴근막장근
  tensorFasciaeLatae("TENSOR_FASCIAE_LATAE"),

  /// 봉공근
  teresMajor("TERES_MAJOR"),

  /// 전경골근
  tibialisAnterior("TIBIALIS_ANTERIOR"),

  /// 승모근
  trapezius("TRAPEZIUS"),

  /// 삼두근
  triceps("TRICEPS");

  final String serverKey;

  const MuscleType(this.serverKey);

  static MuscleType? from(String? rawValue) =>
      values.firstWhereOrNull((e) => e.serverKey == rawValue);

  String toKor() {
    switch(this) {
      case adductorLongus:
        return "장내전근";
      case adductorMagnus:
        return "대내전근";
      case biceps:
        return "이두근";
      case bicepsFemoris:
        return "반건,반막양근";
      case brachialis:
        return "상완근";
      case brachioradialis:
        return "완요골근";
      case deltoid:
        return "삼각근";
      case extensorCarpiUlnaris:
        return "충지신근";
      case extensorDigitorumBrevis:
        return "장모지신근";
      case extensorDigitorumLongus:
        return "장지신근";
      case externalOblique:
        return "외복사근";
      case flexorCarpiRadialis:
        return "주근";
      case gluteus:
        return "둔근";
      case gracilis:
        return "비복근";
      case iliacus:
        return "장골근";
      case iliotibialBand:
        return "장경인대";
      case infraspinatus:
        return "오훼완근";
      case largeRetirement:
        return "대퇴직근";
      case lateralGastrocnemius:
        return "외측광근";
      case latissimusDorsi:
        return "광배근";
      case medialGastrocnemius:
        return "내측광근";
      case oblique:
        return "소원근";
      case palmarisLongus:
        return "척측수근신근";
      case pectoralisMajor:
        return "대흉근";
      case peroneusBrevis:
        return "장비골근";
      case peroneusLongus:
        return "중간광근";
      case pronatorTeres:
        return "원회내근";
      case psoasMajor:
        return "대요근";
      case pubicus:
        return "치골근";
      case quadratusLumborum:
        return "대원근";
      case rectusAbdominis:
        return "복직근";
      case rectusFemoris:
        return "대퇴이두근";
      case sartorius:
        return "가자미근";
      case semimembranosus:
        return "장경인대";
      case semitendinosus:
        return "척추기립근";
      case serratusAnterior:
        return "장장근";
      case soleus:
        return "박근";
      case supinator:
        return "요측수근신근";
      case tensorFasciaeLatae:
        return "대퇴근막장근";
      case teresMajor:
        return "봉공근";
      case tibialisAnterior:
        return "전경골근";
      case trapezius:
        return "승모근";
      case triceps:
        return "삼두근";
    }
  }

  /// 앞 - 하체 - 다리 목록.
  static List<MuscleType> getFrontLegMuscles() {
    return [
      tensorFasciaeLatae,
      teresMajor,
      lateralGastrocnemius,
      largeRetirement,
      semimembranosus,
      extensorDigitorumLongus,
      tibialisAnterior,
      peroneusBrevis,
      extensorDigitorumBrevis,
      iliacus,
      psoasMajor,
      pubicus,
      adductorLongus,
      adductorMagnus,
      soleus,
      medialGastrocnemius,
      peroneusLongus,
      gracilis,
      sartorius,
    ];
  }

  /// 뒤 - 다리 목록.
  static List<MuscleType> getBackLegMuscles() {
    return [
      gluteus,
      semimembranosus,
      rectusFemoris,
      gracilis,
      sartorius,
      adductorMagnus,
      soleus,
    ];
  }

  /// 앞 - 팔 근육.
  static List<MuscleType> getFrontArmMuscles() {
    return [
      deltoid,
      biceps,
      brachioradialis,
      serratusAnterior,
      infraspinatus,
      triceps,
      brachialis,
      pronatorTeres
    ];
  }

  /// 뒤 - 팔 근육.
  static List<MuscleType> getBackArmMuscles() {
    return [
      deltoid,
      brachioradialis,
      supinator,
      extensorCarpiUlnaris,
      triceps,
      flexorCarpiRadialis,
      palmarisLongus,
    ];
  }

  /// 앞 - 몸통 근육.
  static List<MuscleType> getFrontBodyMuscles() {
    return [
      trapezius,
      pectoralisMajor,
      externalOblique,
      rectusAbdominis,
    ];
  }

  /// 뒤 - 몸통 근육.
  static List<MuscleType> getBackBodyMuscles() {
    return [
      oblique,
      quadratusLumborum,
      latissimusDorsi,
      semitendinosus,
    ];
  }
}
