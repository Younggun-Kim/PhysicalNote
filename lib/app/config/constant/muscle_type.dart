import 'package:get/get.dart';

/// 근육 타입.
// TODO: 근육 한글로 변경 작업 필요.
enum MuscleType {
  adductorLongus("ADDUCTOR_LONGUS"),
  adductorMagnus("ADDUCTOR_MAGNUS"),
  biceps("BICEPS"),
  bicepsFemoris("BICEPS_FEMORIS"),
  brachialis("BRACHIALIS"),
  brachioradialis("BRACHIORADIALIS"),
  deltoid("DELTOID"),
  extensorCarpiUlnaris("EXTENSOR_CARPI_ULNARIS"),
  extensorDigitorumBrevis("EXTENSOR_DIGITORUM_BREVIS"),
  extensorDigitorumLongus("EXTENSOR_DIGITORUM_LONGUS"),
  externalOblique("EXTERNAL_OBLIQUE"),
  flexorCarpiRadialis("FLEXOR_CARPI_RADIALIS"),
  gluteus("GLUTEUS"),
  gracilis("GRACILIS"),
  iliacus("ILIACUS"),
  iliotibialBand("ILIOTIBIAL_BAND"),
  infraspinatus("INFRASPINATUS"),
  largeRetirement("LARGE_RETIREMENT"),
  lateralGastrocnemius("LATERAL_GASTROCNEMIUS"),
  latissimusDorsi("LATISSIMUS_DORSI"),
  medialGastrocnemius("MEDIAL_GASTROCNEMIUS"),
  oblique("OBLIQUE"),
  palmarisLongus("PALMARIS_LONGUS"),
  pectoralisMajor("PECTORALIS_MAJOR"),
  peroneusBrevis("PERONEUS_BREVIS"),
  peroneusLongus("PERONEUS_LONGUS"),
  pronatorTeres("PRONATOR_TERES"),
  psoasMajor("PSOAS_MAJOR"),
  pubicus("PUBICUS"),
  quadratusLumborum("QUADRATUS_LUMBORUM"),
  rectusAbdominis("RECTUS_ABDOMINIS"),
  rectusFemoris("RECTUS_FEMORIS"),
  sartorius("SARTORIUS"),
  semimembranosus("SEMIMEMBRANOSUS"),
  semitendinosus("SEMITENDINOSUS"),
  serratusAnterior("SERRATUS_ANTERIOR"),
  soleus("SOLEUS"),
  supinator("SUPINATOR"),
  tensorFasciaeLatae("TENSOR_FASCIAE_LATAE"),
  teresMajor("TERES_MAJOR"),
  tibialisAnterior("TIBIALIS_ANTERIOR"),
  trapezius("TRAPEZIUS"),
  triceps("TRICEPS");

  final String rawValue;

  const MuscleType(this.rawValue);

  static MuscleType? from(String? rawValue) => values.firstWhereOrNull((e) => e.rawValue == rawValue);
}
