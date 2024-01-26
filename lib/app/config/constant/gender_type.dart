import 'package:get/get.dart';

/// 성별 타입
enum GenderType {
  man(code: 'M'),
  woman(code: 'W');

  final String code;

  const GenderType({required this.code});

  static GenderType? from(String? key) =>
      values.firstWhereOrNull((element) => element.code == key);

  @override
  String toString() {
    switch (this) {
      case man:
        return "남자";
      case woman:
        return "여자";
    }
  }
}
