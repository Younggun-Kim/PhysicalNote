import 'package:get/get.dart';

/// 부상 체크 방향 타입.
enum DistinctionType {
  front(serverKey: 'FRONT'),
  back(serverKey: 'BACK');

  final String serverKey;

  /// Key로 초기화
  static DistinctionType? from(String? key) =>
      values.firstWhereOrNull((element) => element.serverKey == key);

  const DistinctionType({required this.serverKey});
}
