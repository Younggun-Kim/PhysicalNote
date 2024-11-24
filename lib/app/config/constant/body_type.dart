import 'package:get/get.dart';

/// 부상체크 몸통 타입.
enum BodyType {
  upper(serverKey: "UPPER_BODY"),
  lower(serverKey: "LOWER_BODY");

  final String serverKey;

  /// Key로 초기화
  static BodyType? from(String? key) =>
      values.firstWhereOrNull((element) => element.serverKey == key);

  const BodyType({required this.serverKey});
}
