import 'package:get/get.dart';

/// 부상 체크 방향 타입.
enum InjuryCheckDirectionType {
  front(serverKey: 'FRONT'),
  back(serverKey: 'BACK');

  final String serverKey;

  /// Key로 초기화
  static InjuryCheckDirectionType? from(String? key) =>
      values.firstWhereOrNull((element) => element.serverKey == key);

  const InjuryCheckDirectionType({required this.serverKey});
}
