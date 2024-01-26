import 'package:get/get.dart';

/// 부상 체크 신체 타입.
enum InjuryCheckBodyPartsType {
  body(serverKey: 'TORSO'),
  leftArm(serverKey: 'ARM_LEFT'),
  rightArm(serverKey: 'ARM_RIGHT'),
  leftLeg(serverKey: 'LEG_LEFT'),
  rightLeg(serverKey: 'LEG_RIGHT');

  final String serverKey;

  /// Key로 초기화
  static InjuryCheckBodyPartsType? from(String? key) =>
      values.firstWhereOrNull((element) => element.serverKey == key);


  const InjuryCheckBodyPartsType({required this.serverKey});
}
