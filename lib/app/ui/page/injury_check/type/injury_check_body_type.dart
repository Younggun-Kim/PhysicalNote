import 'package:get/get.dart';

/// 부상체크 몸통 타입.
enum InjuryCheckBodyType {
  upper(serverKey: "UPPER_BODY"),
  lower(serverKey: "LOWER_BODY");

  final String serverKey;


  /// Key로 초기화
  static InjuryCheckBodyType? from(String? key) =>
      values.firstWhereOrNull((element) => element.serverKey == key);


  const InjuryCheckBodyType({required this.serverKey});
}
