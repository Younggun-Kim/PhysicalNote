import 'package:get/get.dart';
import 'package:physical_note/app/resources/resources.dart';

// TODO: 250201 - 앞 왼쪽팔 오훼완근 이미지
/// 근육 타입.
enum MuscleType {
  /// 장내전근
  adductorLongus("ADDUCTOR_LONGUS"),

  /// 대내전근
  adductorMagnus("ADDUCTOR_MAGNUS"),

  /// 이두근
  biceps("BICEPS"),

  /// 반건반막양근
  // bicepsFemoris2("BICEPS_FEMORIS"),
  semimembranosus("SEMIMEMBRANOSUS"),

  /// 상완근
  brachialis("BRACHIALIS"),

  /// 완요골근
  brachioradialis("BRACHIORADIALIS"),

  /// 삼각근
  deltoid("DELTOID"),

  /// 총지신근
  // extensorCarpiUlnaris2("EXTENSOR_CARPI_ULNARIS"),
  extensorDigitorum("EXTENSOR_DIGITORUM"),

  /// 장모지신근
  // extensorDigitorumBrevis("EXTENSOR_DIGITORUM_BREVIS"),
  extensorHallucisLongus("EXTENSOR_HALLUCIS_LONGUS"),

  /// 장지신근
  extensorDigitorumLongus("EXTENSOR_DIGITORUM_LONGUS"),

  /// 외복사근
  externalOblique("EXTERNAL_OBLIQUE"),

  /// 주근
  // flexorCarpiRadialis("FLEXOR_CARPI_RADIALIS"),
  anconeus("ANCONEUS"),

  /// 둔근
  // gluteus("GLUTEUS"),
  glute("GLUTE"),

  /// 배복근
  // gracilis("GRACILIS"),
  gastrocnemius("GASTROCNEMIUS"),

  /// 장골근
  iliacus("ILIACUS"),

  /// 오훼완근
  // infraspinatus("INFRASPINATUS"),
  coracobrachialis("CORACOBRACHIALIS"),

  /// 대퇴직근
  // largeRetirement("LARGE_RETIREMENT"),
  rectusFemoris("RECTUS_FEMORIS"),

  /// 외측광근
  // lateralGastrocnemius("LATERAL_GASTROCNEMIUS"),
  vastusLateralis("VASTUS_LATERALIS"),

  /// 광배근
  latissimusDorsi("LATISSIMUS_DORSI"),

  /// 내측광근
  // medialGastrocnemius("MEDIAL_GASTROCNEMIUS"),
  vastusMedialis("VASTUS_MEDIALIS"),

  /// 소원근
  // oblique("OBLIQUE"),
  teresMinor("TERES_MINOR"),

  /// 척측수근신근
  // palmarisLongus("PALMARIS_LONGUS"),
  extensorCarpiUlnaris("EXTENSOR_CARPI_ULNARIS"),

  /// 대흉근
  pectoralisMajor("PECTORALIS_MAJOR"),

  /// 장비골근
  // peroneusBrevis("PERONEUS_BREVIS"),
  fibularisLongus("FIBULARIS_LONGUS"),

  /// 중간광근
  // peroneusLongus("PERONEUS_LONGUS"),
  vastusIntermedius("VASTUS_INTERMEDIUS"),

  /// 원회내근
  pronatorTeres("PRONATOR_TERES"),

  /// 대요근
  psoasMajor("PSOAS_MAJOR"),

  /// 치골근
  // pubicus("PUBICUS"),
  pectineus("PECTINEUS"),

  /// 대원근
  // quadratusLumborum("QUADRATUS_LUMBORUM"),
  teresMajor("TERES_MAJOR"),

  /// 복직근
  rectusAbdominis("RECTUS_ABDOMINIS"),

  /// 대퇴이두근
  // rectusFemoris2("RECTUS_FEMORIS"),
  bicepsFemoris("BICEPS_FEMORIS"),

  /// 가자미근
  // sartorius("SARTORIUS"),
  soleus("SOLEUS"),

  /// 장경인대
  // iliotibialBand("ILIOTIBIAL_BAND"),
  itBand("IT_BAND"),

  /// 척추기립근
  // semitendinosus("SEMITENDINOSUS"),
  erectorSprinae("ERECTOR_SPRINAE"),

  /// 장장근
  // serratusAnterior("SERRATUS_ANTERIOR"),
  palmarisLongus("PALMARIS_LONGUS"),

  /// 박근
  // soleus("SOLEUS"),
  gracilis("GRACILIS"),

  /// 요측수근신근
  // supinator("SUPINATOR"),
  extensorCarpiRadialisLongus("EXTENSOR_CARPI_RADIALIS_LONGUS"),

  /// 대퇴근막장근
  tensorFasciaeLatae("TENSOR_FASCIAE_LATAE"),

  /// 봉공근
  // teresMajor("TERES_MAJOR"),
  sartorius("SARTORIUS"),

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
    switch (this) {
      case trapezius:
        return StringRes.TRAPEZIUS.tr;
      case pectoralisMajor:
        return StringRes.PECTORALIS_MAJOR.tr;
      case externalOblique:
        return StringRes.EXTERNAL_OBLIQUE.tr;
      case rectusAbdominis:
        return StringRes.RECTUS_ABDOMINIS.tr;
      case deltoid:
        return StringRes.DELTOID.tr;
      case biceps:
        return StringRes.BICEPS.tr;
      case brachioradialis:
        return StringRes.BRACHIORADIALIS.tr;
      case brachialis:
        return StringRes.BRACHIALIS.tr;
      case pronatorTeres:
        return StringRes.PRONATOR_TERES.tr;
      case palmarisLongus:
        return StringRes.PALMARIS_LONGUS.tr;
      case triceps:
        return StringRes.TRICEPS.tr;
      case tensorFasciaeLatae:
        return StringRes.TENSOR_FASCIAE_LATAE.tr;
      case sartorius:
        return StringRes.SARTORIUS.tr;
      case vastusLateralis:
        return StringRes.VASTUS_LATERALIS.tr;
      case rectusFemoris:
        return StringRes.RECTUS_FEMORIS.tr;
      case itBand:
        return StringRes.IT_BAND.tr;
      case extensorDigitorumLongus:
        return StringRes.EXTENSOR_DIGITORUM_LONGUS.tr;
      case tibialisAnterior:
        return StringRes.TIBIALIS_ANTERIOR.tr;
      case fibularisLongus:
        return StringRes.FIBULARIS_LONGUS.tr;
      case extensorHallucisLongus:
        return StringRes.EXTENSOR_HALLUCIS_LONGUS.tr;
      case iliacus:
        return StringRes.ILIACUS.tr;
      case psoasMajor:
        return StringRes.PSOAS_MAJOR.tr;
      case pectineus:
        return StringRes.PECTINEUS.tr;
      case adductorLongus:
        return StringRes.ADDUCTOR_LONGUS.tr;
      case adductorMagnus:
        return StringRes.ADDUCTOR_MAGNUS.tr;
      case gracilis:
        return StringRes.GRACILIS.tr;
      case vastusMedialis:
        return StringRes.VASTUS_MEDIALIS.tr;
      case vastusIntermedius:
        return StringRes.VASTUS_INTERMEDIUS.tr;
      case gastrocnemius:
        return StringRes.GASTROCNEMIUS.tr;
      case soleus:
        return StringRes.SOLEUS.tr;
      case glute:
        return StringRes.GLUTE.tr;
      case coracobrachialis:
        return StringRes.CORACOBRACHIALIS.tr;
      case teresMinor:
        return StringRes.TERES_MINOR.tr;
      case teresMajor:
        return StringRes.TERES_MAJOR.tr;
      case latissimusDorsi:
        return StringRes.LATISSIMUS_DORSI.tr;
      case erectorSprinae:
        return StringRes.ERECTOR_SPRINAE.tr;
      case extensorCarpiRadialisLongus:
        return StringRes.EXTENSOR_CARPI_RADIALIS_LONGUS.tr;
      case extensorDigitorum:
        return StringRes.EXTENSOR_DIGITORUM.tr;
      case anconeus:
        return StringRes.ANCONEUS.tr;
      case extensorCarpiUlnaris:
        return StringRes.EXTENSOR_CARPI_ULNARIS.tr;
      case bicepsFemoris:
        return StringRes.BICEPS_FEMORIS.tr;
      case semimembranosus:
        return StringRes.SEMIMEMBRANOSUS.tr;
    }
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

  /// 앞 - 팔 근육.
  static List<MuscleType> getFrontArmMuscles() {
    return [
      coracobrachialis,
      triceps,
      brachialis,
      pronatorTeres,
      deltoid,
      biceps,
      brachioradialis,
      palmarisLongus,
    ];
  }

  /// 앞 - 하체 - 다리 목록.
  static List<MuscleType> getFrontLegMuscles() {
    return [
      glute,
      tensorFasciaeLatae,
      sartorius,
      vastusLateralis,
      rectusFemoris,
      itBand,
      extensorDigitorumLongus,
      tibialisAnterior,
      fibularisLongus,
      extensorHallucisLongus,
      soleus,
      gastrocnemius,
      vastusIntermedius,
      vastusMedialis,
      gracilis,
      adductorMagnus,
      adductorLongus,
      pectineus,
      psoasMajor,
      iliacus,
    ];
  }

  /// 뒤 - 몸통 근육.
  static List<MuscleType> getBackBodyMuscles() {
    return [
      teresMinor,
      teresMajor,
      latissimusDorsi,
      erectorSprinae,
    ];
  }

  /// 뒤 - 팔 근육.
  static List<MuscleType> getBackArmMuscles() {
    return [
      deltoid,
      brachioradialis,
      extensorCarpiRadialisLongus,
      extensorDigitorum,
      triceps,
      anconeus,
      extensorCarpiUlnaris,
    ];
  }

  /// 뒤 - 다리 목록.
  static List<MuscleType> getBackLegMuscles() {
    return [
      glute,
      itBand,
      bicepsFemoris,
      gastrocnemius,
      soleus,
      semimembranosus,
      gracilis,
      adductorMagnus,
    ];
  }
}
