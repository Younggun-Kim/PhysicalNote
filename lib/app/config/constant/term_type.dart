// 약관 타입.
import 'package:get/get.dart';

enum TermType {
  privacy,
  service;

  /// Key로 초기화
  static TermType? from(String? key) =>
      values.firstWhereOrNull((element) => element.toString() == key);

  @override
  String toString() {
    super.toString();
    switch (this) {
      case privacy:
        return "PRIVACY";
      case service:
        return "SERVICE";
    }
  }
}
